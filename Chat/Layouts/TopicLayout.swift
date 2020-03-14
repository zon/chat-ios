import Foundation
import UIKit
import PureLayout

class TopicLayout: UIView {
    let head = UIView()
    let title = UILabel()
    let back = UIButton()
    let collection: UICollectionView
    let foot = UIView()
    let inputPlaceholder = UILabel()
    let input = UITextView()
    let send = UIButton()
    
    private var footBottom: NSLayoutConstraint!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: UIScreen.main.bounds)
        
        addSubview(head)
        head.addSubview(title)
        head.addSubview(back)
        addSubview(collection)
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
        back.autoPinEdges(toSuperviewMarginsExcludingEdge: .right)
        back.autoMatchImage(.width, plus: 15)
        
        collection.backgroundColor = .none
        collection.autoPinEdge(toSuperviewEdge: .left)
        collection.autoPinEdge(toSuperviewEdge: .right)
        collection.autoPinEdge(.top, to: .bottom, of: head)
        collection.autoPinEdge(.bottom, to: .top, of: foot)
        
        foot.backgroundColor = .white
        foot.addBorder(edge: .top)
        foot.autoPinEdge(toSuperviewEdge: .left)
        foot.autoPinEdge(toSuperviewEdge: .right)
        footBottom = foot.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
        foot.autoMatch(.height, to: .height, of: input)
        
        let inputInsets = UIEdgeInsets(top: 17, left: 20, bottom: 15, right: 0)
        
        inputPlaceholder.text = "Send message"
        inputPlaceholder.textColor = .systemGray2
        inputPlaceholder.autoPinEdgesToSuperviewEdges(with: inputInsets)
        
        input.textContainer.lineFragmentPadding = 0
        input.textContainerInset = inputInsets
        input.isScrollEnabled = false
        input.backgroundColor = .clear
        input.autoPinEdge(toSuperviewEdge: .left)
        input.autoPinEdge(.right, to: .left, of: send)
        
        send.setImage(UIImage(named: "round_send_black_24pt"), for: .normal)
        send.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
        send.autoMatchImage(.width, plus: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(topic: Topic) {
        title.text = topic.name
    }
    
}
