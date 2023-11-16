//
//  File.swift
//  
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent

struct CreateAnswer: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(Answer.schema)
            .id()
            .field("answer_text", .string, .required)
            .field("question_id", .uuid, .required, .references(Question.schema, "id"))
            .field("is_correct", .bool, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(Answer.schema).delete()
    }
}
