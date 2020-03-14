import Foundation
import UIKit
import PureLayout

class TopicLayout: UIView {
    let head = UIView()
    let title = UILabel()
    let back = UIButton()
    let collection: UICollectionView
    
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
        
        backgroundColor = .white
        
        head.autoPinEdge(toSuperviewEdge: .left)
        head.autoPinEdge(toSuperviewEdge: .right)
        head.autoPinEdge(toSuperviewSafeArea: .top)
        head.autoSetDimension(.height, toSize: 52)
        head.addBorder(edge: .bottom)
        
        title.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        title.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        
        back.setImage(#imageLiteral(resourceName: "ic_chevron_left"), for: .normal)
        back.autoPinEdges(toSuperviewMarginsExcludingEdge: .right)
        back.autoSetDimension(.height, toSize: 50)
        
        collection.backgroundColor = .white
        collection.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        collection.autoPinEdge(.top, to: .bottom, of: head)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(topic: Topic) {
        title.text = topic.name
    }
    
}
