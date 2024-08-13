import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.routes.defaultMaxBodySize = "10mb"
    
    // MARK: Routes
    // register routes
    try routes(app)
}
