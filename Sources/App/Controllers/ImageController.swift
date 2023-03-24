//
//  File.swift
//  
//
//  Created by dongyeongkang on 2023/03/24.
//

import Vapor

struct ImageController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let images = routes.grouped("image")
    }
    
    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[Image]> {
        return Image.query(on: req.db).all()
    }
    
    func createdHandler(_ req: Request) throws -> EventLoopFuture<Image> {
        let image = try req.content.decode(Image.self)
        return image.save(on: req.db).map { image }
    }
    
    func deleteHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Image.find(req.parameters.get(""), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db).transform(to: .noContent) }
    }
}
