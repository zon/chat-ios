import Foundation
import UIKit
import PureLayout

class TopicLayout: UIView {
    let head = UIView()
    let title = UILabel()
    let back = UIButton()
    let messages = UITableView()
    let foot = UIView()
    let inputPlaceholder = UILabel()
    let input = UITextView()
    let send = UIButton()
    
    private var footBottom: NSLayoutConstraint!
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        addSubview(head)
        head.addSubview(title)
        head.addSubview(back)
        addSubview(messages)
        addSubview(foot)
        foot.addSubview(inputPlaceholder)
        foot.addSubview(input)
        foot.addSubview(send)
        
        backgroundColor = .white
        
        head.backgroundColor = .white
        head.autoPinEdge(toSuperviewEdge: .left)
        head.autoPinEdge(toSuperviewEdge: .right)
        head.autoPinEdge(toSuperviewSafeArea: .top)
        head.autoSetDimension(.height, toSize: 52)
        head.addBorder(edge: .bottom)
        
        title.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        title.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        
        back.setImage(#imageLiteral(resourceName: "round_chevron_left_black_24pt"), for: .normal)
        back.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .right)
        back.autoMatchImage(.width, plus: 22)
        
        messages.backgroundColor = .none
        messages.separatorInset = .zero
        messages.allowsSelection = false
        messages.dragInteractionEnabled = false
        messages.autoPinEdge(toSuperviewEdge: .left)
        messages.autoPinEdge(toSuperviewEdge: .right)
        messages.autoPinEdge(.top, to: .bottom, of: head)
        messages.autoPinEdge(.bottom, to: .top, of: foot)
        
        foot.backgroundColor = .white
        foot.addBorder(edge: .top)
        foot.autoPinEdge(toSuperviewEdge: .left)
        foot.autoPinEdge(toSuperviewEdge: .right)
        footBottom = foot.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
        foot.autoMatch(.height, to: .height, of: input)
        
        let inputInsets = UIEdgeInsets(top: 17, left: 20, bottom: 15, right: 0)
        
        inputPlaceholder.text = "Send message"
        inputPlaceholder.textColor = .systemGray2
        inputPlaceholder.font = .systemFont(ofSize: 18)
        inputPlaceholder.autoPinEdgesToSuperviewEdges(with: inputInsets)
        
        input.font = inputPlaceholder.font
        input.textContainer.lineFragmentPadding = 0
        input.textContainerInset = inputInsets
        input.isScrollEnabled = false
        input.backgroundColor = .clear
        input.autoPinEdge(toSuperviewEdge: .left)
        input.autoPinEdge(.right, to: .left, of: send)
        
        send.setImage(UIImage(named: "round_send_black_24pt"), for: .normal)
        send.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
        send.autoMatchImage(.width, plus: 30)
        
        input.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        head.addGestureRecognizer(tap)
        messages.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(topic: Topic) {
        title.text = topic.name
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        if notification.name == UIResponder.keyboardWillHideNotification {
            UIView.animate(withDuration: 0.25) {
                self.footBottom.constant = 0
                self.layoutIfNeeded()
            }
            
        } else {
            guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else { return }
            UIView.animate(withDuration: 0.25) {
                self.footBottom.constant = self.safeAreaInsets.bottom - keyboardHeight
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func dismissKeyboard() {
        input.resignFirstResponder()
    }
    
}

extension TopicLayout: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let isHidden = !input.text.isEmpty
        UIView.animate(withDuration: 0.125, animations: {
            self.inputPlaceholder.alpha = isHidden ? 0 : 1
        })
    }
    
}
