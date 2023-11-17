//
//  Seed.swift
//
//
//  Created by Jasper Lefever on 16/11/2023.
//

import Fluent

struct Seed: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await createCategories(on: database)
    try await createQuestions(on: database)
  }

  func revert(on database: Database) async throws {
    try await Answer.query(on: database).delete()
    try await Question.query(on: database).delete()
    try await Category.query(on: database).delete()
  }

  private func createCategories(on database: Database) async throws {
    try await Category(
      id: UUID("E641D9C1-D9B2-44F3-9F7C-051E3CDF1488"), name: "Movies", icon: "movieclapper"
    ).save(on: database)
    try await Category(
      id: UUID("F41796BA-84A1-4F63-85FE-6D0D933C8628"), name: "Music", icon: "music.note"
    ).save(on: database)
    try await Category(
      id: UUID("242248A7-2D21-4F8F-A4DD-8CD6783843F1"), name: "Sports", icon: "sportscourt"
    ).save(on: database)
    try await Category(
      id: UUID("37AF091B-4678-4F6A-B971-BB5C4EF81788"), name: "Science", icon: "atom"
    )
    .save(on: database)
    try await Category(
      id: UUID("D3CCFF75-D0DF-4195-8633-2D3B9AE2CAEC"), name: "History", icon: "book"
    )
    .save(on: database)
    try await Category(
      id: UUID("BB19AEFF-E41F-43E5-9928-7AF3D7048AB9"), name: "Geography", icon: "map"
    )
    .save(on: database)
    try await Category(
      id: UUID("BCE69F3F-187E-42EB-97F8-1F96E1ADEBB9"), name: "Art", icon: "paintpalette"
    ).save(on: database)
  }

  private func createQuestions(on database: Database) async throws {
    for question in seedData {
      let category = try await Category.find(question.categoryId, on: database)
      let newQuestion: Question = Question(
        questionText: question.questionText, category: category!
      )

      try await newQuestion.save(on: database)

      for answer in question.answers {
        try await Answer(
          answerText: answer.answerText, questionID: newQuestion.id!, isCorrect: answer.isCorrect
        )
        .save(on: database)
      }
    }

  }

}

let seedData: [CreateQuestionRequest] = [
  // Movies category
  CreateQuestionRequest(
    questionText: "What is your favorite movie?",
    categoryId: UUID("E641D9C1-D9B2-44F3-9F7C-051E3CDF1488")!,
    answers: [
      CreateAnswerRequest(answerText: "The Shawshank Redemption", isCorrect: true),
      CreateAnswerRequest(answerText: "Inception", isCorrect: false),
      CreateAnswerRequest(answerText: "The Godfather", isCorrect: false),
    ]
  ),
  CreateQuestionRequest(
    questionText: "Who directed 'Inception'?",
    categoryId: UUID("E641D9C1-D9B2-44F3-9F7C-051E3CDF1488")!,
    answers: [
      CreateAnswerRequest(answerText: "Christopher Nolan", isCorrect: true),
      CreateAnswerRequest(answerText: "Martin Scorsese", isCorrect: false),
      CreateAnswerRequest(answerText: "Quentin Tarantino", isCorrect: false),
    ]
  ),
  CreateQuestionRequest(
    questionText: "Which actor played Neo in 'The Matrix'?",
    categoryId: UUID("E641D9C1-D9B2-44F3-9F7C-051E3CDF1488")!,
    answers: [
      CreateAnswerRequest(answerText: "Keanu Reeves", isCorrect: true),
      CreateAnswerRequest(answerText: "Brad Pitt", isCorrect: false),
      CreateAnswerRequest(answerText: "Tom Hanks", isCorrect: false),
    ]
  ),

  // Music category
  CreateQuestionRequest(
    questionText: "Who is known as the 'King of Pop'?",
    categoryId: UUID("F41796BA-84A1-4F63-85FE-6D0D933C8628")!,
    answers: [
      CreateAnswerRequest(answerText: "Elvis Presley", isCorrect: false),
      CreateAnswerRequest(answerText: "Michael Jackson", isCorrect: true),
      CreateAnswerRequest(answerText: "Prince", isCorrect: false),
    ]
  ),
  CreateQuestionRequest(
    questionText: "Which band released the album 'Abbey Road'?",
    categoryId: UUID("F41796BA-84A1-4F63-85FE-6D0D933C8628")!,
    answers: [
      CreateAnswerRequest(answerText: "The Beatles", isCorrect: true),
      CreateAnswerRequest(answerText: "The Rolling Stones", isCorrect: false),
      CreateAnswerRequest(answerText: "Led Zeppelin", isCorrect: false),
    ]
  ),
  CreateQuestionRequest(
    questionText: "What instrument is Yo-Yo Ma famous for playing?",
    categoryId: UUID("F41796BA-84A1-4F63-85FE-6D0D933C8628")!,
    answers: [
      CreateAnswerRequest(answerText: "Cello", isCorrect: true),
      CreateAnswerRequest(answerText: "Piano", isCorrect: false),
      CreateAnswerRequest(answerText: "Violin", isCorrect: false),
    ]
  ),

  // Sports category
  // Add three sports-related questions here...

  // Science category
  // Add three science-related questions here...

  // History category
  // Add three history-related questions here...

  // Geography category
  // Add three geography-related questions here...

  // Art category
  // Add three art-related questions here...
]
