import Vapor

struct PageResult<T: Content>: Content {
  var totalItems: Int
  var items: [T]
}

struct PageRequest: Content {
  var page: Int
  var perPage: Int
}
