import Foundation
import UIKit

class Label: UILabel {
    
    var padding: UIEdgeInsets {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        padding = .zero
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
}
