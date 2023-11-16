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

  }

  func getAll(req: Request) async throws -> [Question] {
    return try await Question.query(on: req.db)
      .with(\.$answers)
      .with(\.$category)
      .all()
  }

  func create(req: Request) async throws -> Question {
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

    return try await Question.query(on: req.db)
      .with(\.$answers)
      .filter(\.$id == question.id!)
      .first()!
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
