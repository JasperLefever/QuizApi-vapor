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

    func getAll(req: Request) async throws -> Array<Question> {
        return try await Question.query(on: req.db).with(\.$answers).all()
    }
    
    func create(req: Request) async throws -> Question {
        let question = try req.content.decode(Question.self)
        try await question.save(on: req.db)
        return question
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let category = try await Category.find(req.parameters.get("catId"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await category.delete(on: req.db)
        return .noContent
    }

}
