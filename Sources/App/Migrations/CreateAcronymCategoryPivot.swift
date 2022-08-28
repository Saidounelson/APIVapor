//
//  File.swift
//  
//
//  Created by Saidou on 27/08/2022.
//
import Fluent

// 1
struct CreateAcronymCategoryPivot: Migration {
  // 2
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    // 3
    database.schema("acronym-category-pivot")
      .id()
      .field("acronymID", .uuid, .required,
        .references("acronyms", "id", onDelete: .cascade))
      .field("categoryID", .uuid, .required,
        .references("categories", "id", onDelete: .cascade))
      .create()
  }
  
  // 7
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("acronym-category-pivot").delete()
  }
}
