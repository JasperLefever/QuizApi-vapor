//
//  File.swift
//  
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent
import Vapor

struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        
        categories.get(use: getAll)
        categories.post(use: create)
        
    }

    func getAll(req: Request) async throws -> Array<Category> {
        return try await Category.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Category {
        let category = try req.content.decode(Category.self)
        try await category.save(on: req.db)
        return category
    }

}
