//
//  Seed.swift
//
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent

struct Seed: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await createCategories(on: database)
    try await createQuestions(on: database)
  }

  func revert(on database: Database) async throws {
    try await Answer.query(on: database).delete()
    try await Question.query(on: database).delete()
    try await Category.query(on: database).delete()
  }

  private func createCategories(on database: Database) async throws {
    try await Category(name: "Movies", icon: "movieclapper").save(on: database)
    try await Category(name: "Music", icon: "music.note").save(on: database)
    try await Category(name: "Sports", icon: "sportscourt").save(on: database)
    try await Category(name: "Science", icon: "atom").save(on: database)
    try await Category(name: "History", icon: "book").save(on: database)
    try await Category(name: "Geography", icon: "map").save(on: database)
    try await Category(name: "Art", icon: "paintpalette").save(on: database)
  }

  private func createQuestions(on database: Database) async throws {
    let movies = try await Category.query(on: database).filter(\.$name == "Movies").first()
    let music = try await Category.query(on: database).filter(\.$name == "Music").first()
    let sports = try await Category.query(on: database).filter(\.$name == "Sports").first()
    let science = try await Category.query(on: database).filter(\.$name == "Science").first()
    let history = try await Category.query(on: database).filter(\.$name == "History").first()
    let geography = try await Category.query(on: database).filter(\.$name == "Geography").first()
    let art = try await Category.query(on: database).filter(\.$name == "Art").first()
  }

  /*
{
    "questionText": "What is the capital of France?",
    "category": {
        "name": "test",
        "icon": "plus"
    },
    "answers": [
        {
            "answerText": "Paris",
            "isCorrect": true
        },
        {
            "answerText": "Brussels",
            "isCorrect": false
        },
        {
            "answerText": "Sint-Petersburg",
            "isCorrect": false
        }
    ]
}
*/
}
