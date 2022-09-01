//
//  File.swift
//  
//
//  Created by Saidou on 29/08/2022.
//

import Vapor
import Leaf


struct WebsiteController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let webSiteRoutes = routes.grouped("")
        webSiteRoutes.get("index",use: indexHandler)
        routes.get("acronyms", ":acronymID", use: acronymHandler)

    }
    
    
    func indexHandler(_ req: Request)
    -> EventLoopFuture<View> {
        
        Acronym.query(on: req.db).all().flatMap { acronyms in
            let acronymsData = acronyms.isEmpty ? nil : acronyms
            let content = IndexContext(title: "Home page",acronyms: acronymsData)
            return req.view.render("index",content)
        }
    }
    
    func acronymHandler(_ req: Request)
    -> EventLoopFuture<View> {
        Acronym.find(req.parameters.get("acronymID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { acronym in
                // 3
                acronym.$user.get(on: req.db).flatMap { user in
                    // 4
                    let context = AcronymContext(
                        title: acronym.short,
                        acronym: acronym,
                        user: user)
                    return req.view.render("acronym", context)
                }
            }
    }
    
}

struct IndexContext:Encodable {
    let title:String
    let acronyms: [Acronym]?
}


struct AcronymContext: Encodable {
  let title: String
  let acronym: Acronym
  let user: User
}

