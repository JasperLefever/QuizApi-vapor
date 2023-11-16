import Vapor

struct CategoryResult: Content {
  var id: UUID?
  var name: String
  var icon: String
  var amountOfQuestions: Int?

  init(category: Category) {
    self.id = category.id
    self.name = category.name
    self.icon = category.icon
  }

  init(category: Category, amountOfQuestions: Int) {
    self.id = category.id
    self.name = category.name
    self.icon = category.icon
    self.amountOfQuestions = amountOfQuestions
  }
}
