import Foundation
import UIKit

extension UIEdgeInsets {
    
    init(top: CGFloat) {
        self.init(top: top, left: 0, bottom: 0, right: 0)
    }
    
    init(left: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: 0)
    }
    
    init(bottom: CGFloat) {
        self.init(top: 0, left: 0, bottom: bottom, right: 0)
    }
    
    init(right: CGFloat) {
        self.init(top: 0, left: 0, bottom: 0, right: right)
    }
    
    static func +(a: UIEdgeInsets, b: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: a.top + b.top,
            left: a.left + b.left,
            bottom: a.bottom + b.bottom,
            right: a.right + b.right
        )
    }
    
    static func +=(a: inout UIEdgeInsets, b: UIEdgeInsets) {
        a = a + b
    }
    
}
