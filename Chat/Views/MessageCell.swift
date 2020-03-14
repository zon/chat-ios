import Foundation
import UIKit

class MessageCell: UICollectionViewCell {
    let stack = UIStackView()
    let user = UILabel()
    let body = UITextView()
    
    static let identifier = "message-cell"
    
    static func estimate(message: Message, width: CGFloat? = nil) -> CGSize {
        let cell = MessageCell()
        cell.autoSetDimension(.width, toSize: width ?? UIScreen.main.bounds.width)
        cell.setup(message: message)
        cell.layoutSubviews()
        let size = cell.intrinsicContentSize
        return size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stack)
        stack.addArrangedSubview(user)
        stack.addArrangedSubview(body)
        
        backgroundColor = .white
        addBorder(edge: .bottom)
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 5
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 12, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.autoMatch(.width, to: .width, of: self)
        
        body.isEditable = false
        body.isScrollEnabled = false
        body.textContainer.lineFragmentPadding = 0
        body.textContainerInset = .zero
        
        autoMatch(.height, to: .height, of: stack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(message: Message) {
        user.text = message.user.name
        body.text = message.content
    }
    
}
