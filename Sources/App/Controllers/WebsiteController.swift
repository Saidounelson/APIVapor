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
    let webSiteRoutes = routes.grouped("index")
      webSiteRoutes.get(use: indexHandler)
  }


  func indexHandler(_ req: Request)
    -> EventLoopFuture<View> {
        
        Acronym.query(on: req.db).all().flatMap { acronyms in
            let acronymsData = acronyms.isEmpty ? nil : acronyms
            let content = IndexContext(title: "Home page",acronyms: acronymsData)
             return req.view.render("index",content)
        }
  }
    
    
}

struct IndexContext:Encodable {
    let title:String
    let acronyms: [Acronym]?
    
}
