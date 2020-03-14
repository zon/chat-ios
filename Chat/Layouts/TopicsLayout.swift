import Foundation
import UIKit
import PureLayout

class TopicsLayout: UIView {
    let head = UIView()
    let titleSection = UIView()
    let title = UILabel()
    let createSection = UIView()
    let createName = TextField()
    let create = UIButton()
    let collection: UICollectionView
    
    private let headClosed: CGFloat = 52
    private let headOpened: CGFloat = 110
    private var headHeight: NSLayoutConstraint!
    private var headBorder: UIView!
    private var createBottom: NSLayoutConstraint!
    private var createHeight: NSLayoutConstraint!
    
    var createOpen: Bool {
        get {
            return !createSection.isHidden
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: UIScreen.main.bounds)
        
        addSubview(head)
        head.addSubview(createSection)
        createSection.addSubview(createName)
        head.addSubview(titleSection)
        titleSection.addSubview(title)
        head.addSubview(create)
        addSubview(collection)
        
        backgroundColor = .white
        
        head.clipsToBounds = true
        head.autoPinEdge(toSuperviewEdge: .left)
        head.autoPinEdge(toSuperviewEdge: .right)
        head.autoPinEdge(toSuperviewSafeArea: .top)
        headHeight = head.autoSetDimension(.height, toSize: headClosed)
        headBorder = head.addBorder(edge: .bottom)
        
        createSection.backgroundColor = .systemGreen
        createSection.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        createSection.autoSetDimension(.height, toSize: 60)
        createSection.isHidden = true
        
        createName.placeholder = "New topic name"
        createName.padding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 5)
        createName.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        createName.autoPinEdge(.right, to: .left, of: create)
        
        titleSection.backgroundColor = .white
        titleSection.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        titleSection.autoSetDimension(.height, toSize: 50)
        
        title.text = "Topics"
        title.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        title.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        
        create.setImage(UIImage(named: "round_add_black_24pt"), for: .normal)
        create.autoPinEdge(toSuperviewEdge: .right)
        createBottom = create.autoPinEdge(toSuperviewEdge: .bottom, withInset: 2)
        create.autoMatchImage(.width, plus: 32)
        createHeight = create.autoSetDimension(.height, toSize: 50)
        
        collection.backgroundColor = .white
        collection.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        collection.autoPinEdge(.top, to: .bottom, of: head)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideCreate))
        tap.cancelsTouchesInView = false
        titleSection.addGestureRecognizer(tap)
        collection.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showCreate() {
        headHeight.constant = headOpened
        createSection.isHidden = false
        createBottom.constant = 0
        createHeight.constant = 60
        createName.becomeFirstResponder()
        UIView.animate(withDuration: 0.25, animations: {
            self.headBorder.alpha = 0
            self.create.tintColor = .white
            self.layoutIfNeeded()
        }) { _ in
            self.headBorder.isHidden = true
        }
    }
    
    @objc func hideCreate() {
        headHeight.constant = headClosed
        headBorder.isHidden = false
        createBottom.constant = -2
        createHeight.constant = 50
        createName.text = nil
        createName.resignFirstResponder()
        UIView.animate(withDuration: 0.25, animations: {
            self.headBorder.alpha = 1
            self.create.tintColor = .systemBlue
            self.layoutIfNeeded()
        }) { _ in
            self.createSection.isHidden = true
        }
    }
    
}
