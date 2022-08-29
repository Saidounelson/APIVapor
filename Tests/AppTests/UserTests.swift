//
//  File.swift
//  
//
//  Created by Saidou on 28/08/2022.
//

@testable import App
import XCTVapor
final class UserTests: XCTestCase {
    func testUsersCanBeRetrievedFromAPI() throws {
        
        let app = Application(.testing)
        
        defer { app.shutdown() }
        
        try configure(app)
        
        let expectedName = "test1"
        let expectedUsername = "test1"
        
        let user = User(
            name: expectedName,
            username: expectedUsername)
        try user.save(on: app.db).wait()
        

        try app.test(.GET, "/api/users", afterResponse: { response in
        
            XCTAssertEqual(response.status, .ok)
            
            let users = try response.content.decode([User].self)
            
            XCTAssertEqual(users.count, 12)
            XCTAssertEqual(users[11].name, expectedName)
            XCTAssertEqual(users[11].username, expectedUsername)
            XCTAssertEqual(users[11].id, user.id)
        })
    }
    
}
