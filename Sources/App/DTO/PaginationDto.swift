import Vapor

struct PageResult<T: Content>: Content {
  var metadata: PageMetadata
  var items: [T]
}

struct PageRequest: Content {
  var page: Int
  var perPage: Int
}

struct PageMetadata: Content {
  var page: Int
  var perPage: Int
  var totalItems: Int
  var totalPages: Int
}
