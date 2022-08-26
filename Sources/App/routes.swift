import Fluent
import Vapor
import Dispatch

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    // Create new acronyms
    app.post("api", "acronyms") { req -> EventLoopFuture<Acronym> in
          let acronym = try req.content.decode(Acronym.self)
          return acronym.save(on: req.db).map {
            acronym
          }
        }
    // Find all acronyms
    app.get("api","acronyms") { req -> EventLoopFuture<[Acronym]> in
            Acronym.query(on: req.db).all()
        }
    // Fond acronyms by id
    app.get("api","acronyms",":acronymID"){
           req -> EventLoopFuture<Acronym> in
           Acronym.find(req.parameters.get("acronymID"), on: req.db)
               .unwrap(or: Abort(.notFound,reason: "acronyms is not found"))
       }
    // Update acronyms
    app.put("api","acronyms",":acronymID") { req -> EventLoopFuture<Acronym> in
            let updateAcronym = try req.content.decode(Acronym.self)
            
            return Acronym.find(req.parameters.get("acronymID"), on: req.db)
                .unwrap(or: Abort(.notFound,reason: "acronymID is not found")).flatMap{
                    acronym in
                    acronym.short = updateAcronym.short
                    acronym.long = updateAcronym.long
                    return acronym.save(on: req.db).map{acronym}
                }
            
        }
    // Delete acronyms
    app.delete("api","acronyms",":acronymID"){ req -> EventLoopFuture<HTTPStatus> in
        Acronym.find(req.parameters.get("acronymID"), on: req.db)
            .unwrap(or: Abort(.notFound,reason: "acronymID is not found"))
            .flatMap{
                acronym in
                acronym.delete(on: req.db)
                    .transform(to: .noContent)
            }
        
    }
    
    app.get("api","acronyms","search"){
        req -> EventLoopFuture<[Acronym]> in
        guard let searchTerm = req.query[String.self,at:"term"] else {
            throw Abort(.badRequest,reason: "term is not found")
        }
        return Acronym.query(on: req.db).group(.or) { or in
                or.filter(\.$short == searchTerm)
                or.filter(\.$long == searchTerm)
            
        }.all()
            
    }

}
