import Foundation
import UIKit
import PureLayout

class TopicsLayout: UIView {
    let head = UIView()
    let title = UILabel()
    let collection: UICollectionView
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: UIScreen.main.bounds)
        
        addSubview(head)
        head.addSubview(title)
        addSubview(collection)
        
        backgroundColor = .white
        
        head.autoPinEdge(toSuperviewEdge: .left)
        head.autoPinEdge(toSuperviewEdge: .right)
        head.autoPinEdge(toSuperviewSafeArea: .top)
        head.autoSetDimension(.height, toSize: 52)
        head.addBorder(edge: .bottom)
        
        title.text = "Topics"
        title.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        title.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        
        collection.backgroundColor = .white
        collection.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        collection.autoPinEdge(.top, to: .bottom, of: head)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
