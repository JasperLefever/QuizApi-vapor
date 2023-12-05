//
//  File.swift
//  
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Vapor
import Fluent

final class Category: Model, Content {
    static let schema : String = "categories"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "icon")
    var icon: String
    
    @Children(for: \.$category)
    var questions: [Question]
    
    init() { }

    init(id: UUID? = nil, name: String, icon: String) {
        self.id = id
        self.name = name
        self.icon = icon
    }
}
