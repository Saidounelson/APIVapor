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

    routes.get(use: indexHandler)
  }


  func indexHandler(_ req: Request)
    -> EventLoopFuture<View> {
      
      return req.view.render("index")
  }
}

