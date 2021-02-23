import Vapor

public func routes(_ app: Application) throws {
    // This is the root Route
    app.get { req in
        return "Welcome to Million Hairs"
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
