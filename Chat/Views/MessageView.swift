import Foundation
import UIKit

class MessageView: UIView {
    let stack = UIStackView()
    let user = UILabel()
    let body = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stack)
        stack.axis = .vertical
        stack.alignment = .fill
//        stack.autoPinEdge(toSuperViewEdge: .left)
        
        stack.addArrangedSubview(user)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
