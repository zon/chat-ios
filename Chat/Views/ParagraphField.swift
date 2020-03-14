import Foundation
import UIKit
import PureLayout

class ParagraphField: UIView, UITextViewDelegate {
    let placeholder = Label()
    private let field = UITextView()
    
    var padding: UIEdgeInsets {
        get {
            return field.textContainerInset
        }
        set(padding) {
            placeholder.padding = padding
            field.textContainerInset = padding
        }
    }
    
    var font: UIFont? {
        get {
            return field.font
        }
        set(font) {
            placeholder.font = font
            field.font = font
        }
    }
    
    var text: String? {
        get {
            if field.text.isEmpty {
                return nil
            } else {
                return field.text
            }
        }
        set(text) {
            field.text = text
            updatePlaceholder(animate: false)
        }
    }
    
    var isEditable: Bool {
        get {
            return field.isEditable
        }
        set(isEditable) {
            field.isEditable = isEditable
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(placeholder)
        addSubview(field)
        
        placeholder.textColor = .placeholderText
        placeholder.autoPinEdgesToSuperviewEdges()
        
        field.textContainer.lineFragmentPadding = 0
        field.textContainerInset = padding
        field.isScrollEnabled = false
        field.backgroundColor = .clear
        field.autoPinEdgesToSuperviewEdges()
        
        field.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholder(animate: true)
    }
    
    private func updatePlaceholder(animate: Bool) {
        if animate {
            UIView.animate(withDuration: 0.125, animations: {
                self.updatePlaceholder(animate: false)
            })
        } else {
            let isHidden = !field.text.isEmpty || !field.isEditable
            placeholder.alpha = isHidden ? 0 : 1
        }
    }
    
}
