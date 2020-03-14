import Foundation
import UIKit
import PureLayout

extension UIButton {
    
    @discardableResult
    func autoMatchImage(_ dimension: ALDimension, plus: CGFloat = 0) -> NSLayoutConstraint? {
        if let size = image(for: .normal)?.size {
            let length = dimension == .width ? size.width : size.height
            return autoSetDimension(dimension, toSize: length + plus)
        } else {
            return nil
        }
    }
    
}
