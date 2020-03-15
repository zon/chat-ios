import Foundation

struct Message: Hashable, Codable, Identifiable {
    let id = UUID()
    let user: User
    var content: String
    let created = Date()
}
