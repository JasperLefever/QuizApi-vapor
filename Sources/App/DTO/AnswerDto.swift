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

  init(answer: Answer) {
    self.id = answer.id
    self.answerText = answer.answerText
    self.isCorrect = answer.isCorrect
    self.questionId = answer.$question.id
  }
}
