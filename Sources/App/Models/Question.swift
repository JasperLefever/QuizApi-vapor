//
//  File.swift
//
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent
import Vapor

final class Question: Model, Content {
  static let schema = "questions"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "question_text")
  var questionText: String

  @Parent(key: "category_id")
  var category: Category

  @Children(for: \.$question)
  var answers: [Answer]

  init() {}

  init(id: UUID? = nil, questionText: String, categoryID: UUID) {
    self.id = id
    self.questionText = questionText
    self.$category.id = categoryID
  }

  init(questionText: String, category: Category) {
    self.questionText = questionText
    self.$category.id = category.id!
  }
}
