import Fluent
import Vapor
import Dispatch

func routes(_ app: Application) throws {

    app.get("") { req async in
        "WELCOME TO API VAPOR"
    }
    
    let acronymsController = AcronymsController()
    try app.register(collection: acronymsController)
    
    
    let usersController = UsersController()
    try app.register(collection: usersController)
    
    let categoriesController = CategoriesController()
    try app.register(collection: categoriesController)
    
    let websiteController=WebsiteController()
    try app.register(collection: websiteController)

}
