//
//  File.swift
//  
//
//  Created by Saidou on 27/08/2022.
//

import Fluent
import Vapor
import Foundation

final class User: Model,Content{
    static let schema = "users"
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name:String
    
    @Field(key: "username")
    var username:String
    @Children(for: \.$user)
    var acronyms: [Acronym]

    init()  {
    }
    
    init(id: UUID? = nil, name: String, username: String) {
        self.name = name
        self.username = username
    }
    
}
