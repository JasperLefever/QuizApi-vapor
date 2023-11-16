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
        let categories = routes.grouped("todos")
        categories.get(use: getAll)
    }

    func getAll(req: Request) async throws -> Array<Category> {
        try await Category.query(on: req.db).all()
    }

}
