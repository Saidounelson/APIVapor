import Fluent
import Vapor
import Dispatch

func routes(_ app: Application) throws {

    app.get { req async in
        "It works!"
    }
    
    let acronymsController = AcronymsController()
    try app.register(collection: acronymsController)
    
    
    let usersController = UsersController()
    try app.register(collection: usersController)
    
    let categoriesController = CategoriesController()
    try app.register(collection: categoriesController)


}
