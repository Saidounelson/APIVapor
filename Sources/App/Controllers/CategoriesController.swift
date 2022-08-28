//
//  File.swift
//  
//
//  Created by Saidou on 27/08/2022.
//

import Vapor

// 1
struct CategoriesController: RouteCollection {
  // 2
  func boot(routes: RoutesBuilder) throws {
    // 3
    let categoriesRoute = routes.grouped("api", "categories")
    // 4
    categoriesRoute.post(use: createHandler)
    categoriesRoute.get(use: getAllHandler)
    categoriesRoute.get(":categoryID", use: getHandler)
  }
  
  // 5
  func createHandler(_ req: Request)
    throws -> EventLoopFuture<Category> {
    let category = try req.content.decode(Category.self)
    return category.save(on: req.db).map { category }
  }
  
  func getAllHandler(_ req: Request)
    -> EventLoopFuture<[Category]> {
    Category.query(on: req.db).all()
  }
  
  func getHandler(_ req: Request)
    -> EventLoopFuture<Category> {
    Category.find(req.parameters.get("categoryID"), on: req.db)
      .unwrap(or: Abort(.notFound))
  }
}
