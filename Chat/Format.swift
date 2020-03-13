import Foundation

public class Format {
    
    static let shortTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    public static func shortTime(_ date: Date) -> String {
        return shortTimeFormatter.string(from: date)
    }
    
}
