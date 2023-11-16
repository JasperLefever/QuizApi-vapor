import Vapor

struct PageRequest: Content {
  var page: Int?
  var perPage: Int?
}
