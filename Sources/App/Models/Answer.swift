//
//  File.swift
//
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent
import Vapor

final class Answer: Model, Content {
  static let schema = "answers"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "answer_text")
  var answerText: String

  @Parent(key: "question_id")
  var question: Question

  @Field(key: "is_correct")
  var isCorrect: Bool

  init() {}

  init(id: UUID? = nil, answerText: String, questionID: UUID, isCorrect: Bool) {
    self.id = id
    self.answerText = answerText
    self.$question.id = questionID
    self.isCorrect = isCorrect
  }

  init(answerText: String, question: Question, isCorrect: Bool) {
    self.answerText = answerText
    self.$question.id = question.id!
    self.isCorrect = isCorrect
  }
}
