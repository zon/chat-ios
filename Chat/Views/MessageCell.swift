import Foundation
import UIKit

class MessageCell: UITableViewCell {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stack)
        stack.addArrangedSubview(user)
        stack.addArrangedSubview(body)
        
        backgroundColor = .white
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 5
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 12, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.autoPinEdgesToSuperviewEdges()
        
        user.font = .systemFont(ofSize: 12, weight: .light)
        
        body.font = .systemFont(ofSize: 18)
        body.isEditable = false
        body.isScrollEnabled = false
        body.textContainer.lineFragmentPadding = 0
        body.textContainerInset = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(message: Message) {
        user.text = message.user.name
        body.text = message.content
    }
    
}
