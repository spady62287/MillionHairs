import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    
    // Using template engines, instead of rebuilding entire files for HTML
    
    // Templates allow you to write all your view code in HTML, JavaScript, and CSS
    
    // Swift code acts as the controller, responsible for fetching data from your model
    
    // Templates like Leaf load HTML code, customize it based on any dynamic data you want to pass in, then send to Vapor for rendering
    
    app.views.use(.leaf)

    try routes(app)
}
