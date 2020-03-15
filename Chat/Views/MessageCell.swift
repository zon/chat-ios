import Foundation
import UIKit

class MessageCell: UITableViewCell {
    let stack = UIStackView()
    let user = Label()
    let body = ParagraphField()
    let edit = UIView()
    let cancel = UIButton()
    let save = UIButton()
    
    private(set) var index: IndexPath?
    private(set) var message: Message?
    weak var delegate: MessageCellDelegate?
    
    static let identifier = "message-cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stack)
        stack.addArrangedSubview(user)
        stack.addArrangedSubview(body)
        stack.addArrangedSubview(edit)
        edit.addSubview(cancel)
        edit.addSubview(save)
        
        backgroundColor = .white
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.autoPinEdgesToSuperviewEdges()
        
        user.font = .systemFont(ofSize: 12, weight: .light)
        user.padding = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        
        body.font = .systemFont(ofSize: 18)
        body.isEditable = false
        body.padding = UIEdgeInsets(top: 5, left: 20, bottom: 10, right: 20)
        
        edit.isHidden = true
        
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(.systemGray, for: .normal)
        cancel.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        cancel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        
        save.setTitle("Save", for: .normal)
        save.setTitleColor(.systemBlue, for: .normal)
        save.contentEdgeInsets = cancel.contentEdgeInsets
        save.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
        
        cancel.addTarget(self, action: #selector(onCancel), for: .touchUpInside)
        save.addTarget(self, action: #selector(onSave), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(index: IndexPath?, message: Message, isEditing: Bool) {
        self.index = index
        self.message = message
        user.text = message.user.name
        body.text = message.content
        if isEditing {
            showEdit()
        } else {
            hideEdit()
        }
    }
    
    private func showEdit() {
        edit.isHidden = false
        body.isEditable = true
        body.placeholder.text = "Edit message"
    }
    
    private func hideEdit() {
        body.isEditable = false
        edit.isHidden = true
    }
    
    @objc func onCancel() {
        delegate?.onCancel(cell: self)
    }
    
    @objc func onSave() {
        delegate?.onSave(cell: self)
    }
    
}

protocol MessageCellDelegate: class {
    
    func onCancel(cell: MessageCell)
    func onSave(cell: MessageCell)
    
}
