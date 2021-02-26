import Vapor
import Foundation
import Leaf

public func routes(_ app: Application) throws {
    // This is the root Route
    app.get() { req in
        req.leaf.render("child", [
            "title": "Hello",
            "body": "Welcome to Million Hairs"
        ])
    };
    app.get("info") { req -> EventLoopFuture<View> in
        let context = [String: String]()
        return req.view.render("index", context)
    };
    app.get("staff", ":name") { req -> EventLoopFuture<View> in
        
        let name = req.parameters.get("name")!
        
        // Dummy Data to Display
        let bios = [
            "jason": "I'm the Red Power Ranger",
            "zack": "I'm the Black Power Ranger",
            "kimberly": "I'm the Pink Power Ranger",
            "tommy": "I'm the Green Ranger",
            "billy": "I'm The Blue Power Ranger"
        ]
        
        // Define Struct we'll pass to the template
        struct StaffView: Codable {
            var name: String?
            var bio: String?
            var isAvailable: Bool?
        }
        
        // Variable with Type of above Struct
        let context: StaffView
        
        // Map staff name to bio and display
        // Else Create a Blank Instance
        if let bio = bios[name] {
            context = StaffView(name: name, bio: bio, isAvailable: true)
        } else {
            context = StaffView(name: "", bio: "", isAvailable: false)
        }
        
        // Render template with the context
        return req.view.render("staff", context)
    };
    app.get("contact") { req in
        return "Get in touch with us"
    };
    app.get("title") { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    };
    app.get("works") { req in
        return "It works!"
    };
    app.get("hello") { req -> String in
        return "Hello, world!"
    };
}
