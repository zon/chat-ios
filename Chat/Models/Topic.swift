import Foundation

struct Topic: Hashable, Codable, Identifiable {
    let id = UUID()
    let name: String
    
    var messages: [Message]
    
    init(name: String) {
        self.name = name
        self.messages = []
        
        let alice = User(name: "Alice")
        let bob = User(name: "Bob")
        
        let messages = [
            Message(user: bob, content: "Hi"),
            Message(user: alice, content: "Hey"),
            Message(user: bob, content: "Bew bew"),
            Message(user: alice, content: "Bew bew bew")
        ]
        self.messages = messages
    }
    
}
