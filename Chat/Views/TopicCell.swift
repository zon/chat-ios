import Foundation
import UIKit

class TopicCell: UICollectionViewCell {
    let name = UILabel()
    let chevron = UIImageView(image: #imageLiteral(resourceName: "ic_chevron_right"))
    
    static let identifier = "topic-view"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(name)
        addSubview(chevron)
        
        addBorder(edge: .bottom)
        layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 12, right: 20)
        
        name.autoPinEdge(toSuperviewMargin: .left)
        name.autoPinEdge(.right, to: .left, of: chevron, withOffset: 10)
        name.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        
        chevron.autoPinEdge(toSuperviewMargin: .right)
        chevron.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(topic: Topic) {
        name.text = topic.name
    }
    
}
