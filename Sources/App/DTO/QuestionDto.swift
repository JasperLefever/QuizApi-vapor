import Vapor

// Request DTO
struct CreateQuestionRequest: Content {
  var questionText: String
  var categoryId: UUID
  var answers: [CreateAnswerRequest]
}

// Response DTO
struct QuestionResult: Content {
  var id: UUID?
  var questionText: String
  var category: CategoryResult
  var answers: [AnswerResult]

  init(question: Question) {
    self.id = question.id
    self.questionText = question.questionText
    self.category = CategoryResult(category: question.category)
    self.answers = question.answers.map { AnswerResult(answer: $0) }
  }
}
