import Vapor

struct CreateAnswerRequest: Content {
  var answerText: String
  var isCorrect: Bool
}

struct AnswerResult: Content {
  var id: UUID?
  var answerText: String
  var isCorrect: Bool
  var questionId: UUID
}
