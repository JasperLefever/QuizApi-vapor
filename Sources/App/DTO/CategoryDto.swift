import Vapor

struct CategoryResult: Content {
    var id: UUID?
    var name: String
    var icon: String
    
    init(category: Category) {
        self.id = category.id
        self.name = category.name
        self.icon = category.icon
    }
    
}

struct CategoryWithCount: Content {
    var id: UUID
    var name: String
    var icon: String
    var questionCount: Int
}
