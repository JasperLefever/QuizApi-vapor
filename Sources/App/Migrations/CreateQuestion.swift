//
//  File.swift
//
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent

struct CreateQuestion: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema(Question.schema)
      .id()
      .field("question_text", .string, .required)
      .field("category_id", .uuid, .required, .references(Category.schema, "id"))
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema(Question.schema).delete()
  }
}
