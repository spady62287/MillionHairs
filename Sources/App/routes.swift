import Vapor
import Foundation
import Leaf

public func routes(_ app: Application) throws {
    // This is the root Route
    app.get() { req in
        req.leaf.render(template: "home", context: [
            "title": "Hello",
            "body": "Welcome to Million Hairs"
        ])
    };
    app.get("info") { req -> EventLoopFuture<View> in
        let context = [String: String]()
        return req.view.render("index", context)
    };
    app.get("staff") { req in
        return "Meet our great team"
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
