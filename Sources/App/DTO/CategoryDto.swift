import Vapor

struct CategoryResult: Content {
  var id: UUID?
  var name: String
  var icon: String
}
