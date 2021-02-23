import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    
    // Using template engines, instead of rebuilding entire files for HTML
    
    // Templates allow you to write all your view code in HTML, JavaScript, and CSS
    
    // Swift code acts as the controller, responsible for fetching data from your model
    
    // Templates like Leaf load HTML code, customize it based on any dynamic data you want to pass in, then send to Vapor for rendering

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    if !app.environment.isRelease {
        LeafRenderer.Option.caching = .bypass
    }
    
    let detected = LeafEngine.rootDirectory ?? app.directory.viewsDirectory
    LeafEngine.rootDirectory = detected

    let defaultSource = NIOLeafFiles(fileio: app.fileio,
                                     limits: .default,
                                     sandboxDirectory: detected,
                                     viewDirectory: detected,
                                     defaultExtension: "leaf")

    let customSource = CustomSource()

    let multipleSources = LeafSources()
    try multipleSources.register(using: defaultSource)
    try multipleSources.register(source: "custom-source-key", using: customSource)

    LeafEngine.sources = multipleSources
    
    app.views.use(.leaf)

    try routes(app)
}

struct CustomSource: LeafSource {

    func file(template: String, escape: Bool, on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        /// Your custom lookup method comes here...
        return eventLoop.future(error: LeafError(.noTemplateExists(template)))
    }
}
