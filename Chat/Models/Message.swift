import Foundation

struct Message: Hashable, Codable, Identifiable {
    let id = UUID()
    let user: User
    let content: String
    let created = Date()
}
