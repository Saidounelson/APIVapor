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
      print("Here")
      return req.view.render("index")
  }
}

