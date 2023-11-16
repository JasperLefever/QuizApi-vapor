//
//  File.swift
//  
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent
import Vapor

final class Question: Model, Content {
    static let schema = "questions"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "question_text")
    var questionText: String
    
    @Parent(key: "correct_answer_id")
    var correctAnswer: Answer
    
    @Parent(key: "category_id")
    var category: Category
    
    init() { }

    init(id: UUID? = nil, questionText: String, correctAnswerID: UUID, categoryID: UUID) {
        self.id = id
        self.questionText = questionText
        self.$correctAnswer.id = correctAnswerID
        self.$category.id = categoryID
    }
}
