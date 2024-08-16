import Vapor
import FluentKit

func routes(_ app: Application) throws {
    app.get { req -> String in
        "Connected"
    }
    
    let api = app.grouped("v1")
    try api.group(EnsureApiDomainMiddleware()) { api in
        try api.register(collection: ImageUploadController())
    }
}

