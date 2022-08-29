//
//  File.swift
//  
//
//  Created by Saidou on 27/08/2022.
//

import Fluent


struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("username", .string, .required)
        
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}