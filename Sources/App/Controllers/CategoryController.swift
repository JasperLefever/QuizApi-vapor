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
    categories.delete(":catId", use: delete)

  }

  func getAll(req: Request) async throws -> Page<Category> {
    let pageReq = try req.query.decode(PageRequest.self)
    return try await Category.query(on: req.db)
      .paginate(
        FluentKit.PageRequest(
          page: pageReq.page ?? 1,
          per: pageReq.perPage ?? 10
        )
      )
  }

  func getCountPerCategory(req: Request) async throws -> Int {
    guard let category = try await Category.find(req.parameters.get("catId"), on: req.db) else {
      throw Abort(.notFound)
    }
    return try await Question.query(on: req.db)
      .filter(\.$category.$id == category.id!)
      .count()
  }

  func create(req: Request) async throws -> Category {
    let category = try req.content.decode(Category.self)
    try await category.save(on: req.db)
    return category
  }

  func delete(req: Request) async throws -> HTTPStatus {
    guard let category = try await Category.find(req.parameters.get("catId"), on: req.db) else {
      throw Abort(.notFound)
    }
    try await category.delete(on: req.db)
    return .noContent
  }

}
