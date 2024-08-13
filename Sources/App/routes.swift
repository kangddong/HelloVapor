import Vapor
import FluentKit

func routes(_ app: Application) throws {
    let v1Routes = app.grouped("v1")
    v1Routes.post("images", "upload") { req -> EventLoopFuture<Response> in
        struct ImageUpload: Content {
            var file: File
        }
        
        do {
            let imageUpload = try req.content.decode(ImageUpload.self)
            let file = imageUpload.file
            let savePath = "Public/images/\(file.filename)"
            print("savePath: \(savePath)")
            
            return req.fileio.writeFile(file.data, at: savePath)
                .map {
                    let response = ["status": "success upload", "fileName": file.filename]
                    return Response(status: .ok, body: .init(string: response.description))
                }
        } catch {
            let response = ["status": "error", "message": "Failed to decode request"]
            return req.eventLoop.makeSucceededFuture(
                Response(status: .ok, body: .init(string: response.description))
            )
        }
    }
}

