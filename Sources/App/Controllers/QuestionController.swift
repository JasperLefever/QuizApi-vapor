//
//  File.swift
//
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent
import Vapor

struct QuestionController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let questions = routes.grouped("questions")

    questions.get(use: getAll)
    questions.post(use: create)
    questions.delete(":questionId", use: delete)

  }

  func getAll(req: Request) async throws -> Page<QuestionResult> {
    let pageReq = try req.query.decode(PageRequest.self)
    let page = try await Question.query(on: req.db)
      .with(\.$answers)
      .with(\.$category)
      .paginate(
        FluentKit.PageRequest(
          page: pageReq.page ?? 1,
          per: pageReq.perPage ?? 10
        )
      )

    let questions = page.items.map { QuestionResult(question: $0) }
    let questionPage = Page(items: questions, metadata: page.metadata)

    return questionPage
  }

  func create(req: Request) async throws -> QuestionResult {
    let questionReq = try req.content.decode(CreateQuestionRequest.self)
    guard let category = try await Category.find(questionReq.categoryId, on: req.db) else {
      throw Abort(.notFound)
    }

    let question = Question(
      questionText: questionReq.questionText,
      category: category)

    try await question.save(on: req.db)

    for answer in questionReq.answers {
      let answer = Answer(
        answerText: answer.answerText,
        question: question,
        isCorrect: answer.isCorrect)
      try await answer.save(on: req.db)
    }

    let res = try await Question.query(on: req.db)
      .with(\.$answers)
      .with(\.$category)
      .filter(\.$id == question.id!)
      .first()!
    return QuestionResult(question: res)
  }

  func delete(req: Request) async throws -> HTTPStatus {
    guard
      let question = try await Question.find(
        req.parameters.get("questionId", as: UUID.self), on: req.db)
    else {
      throw Abort(.notFound)
    }

    try await Answer.query(on: req.db)
      .filter(\.$question.$id == question.id!)
      .delete()
    try await question.delete(on: req.db)
    return .noContent
  }

}
