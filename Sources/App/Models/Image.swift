//
//  Image.swift
//  
//
//  Created by dongyeongkang on 2023/03/24.
//

import Fluent
import Vapor

final class Image: Model, Content {
    static let schema = "images"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "image")
    var image: String
    
    init() {}
    
    init(id: UUID? = nil, image: String) {
        self.id = id
        self.image = image
    }
}

