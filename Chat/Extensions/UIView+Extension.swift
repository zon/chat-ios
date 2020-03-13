import Foundation
import UIKit
import PureLayout

extension UIView {
    
    func addBorder(edge: ALEdge, width: CGFloat = 2, color: UIColor = .systemGray6) {
        let line = UIView()
        addSubview(line)
        line.backgroundColor = color
        switch edge {
        case .left:
            line.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
            line.autoSetDimension(.width, toSize: width)
            layoutMargins += UIEdgeInsets(left: width)
        case .right:
            line.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
            line.autoSetDimension(.width, toSize: width)
            layoutMargins += UIEdgeInsets(right: width)
        case .top:
            line.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
            line.autoSetDimension(.height, toSize: width)
            layoutMargins += UIEdgeInsets(top: width)
        case .bottom:
            line.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
            line.autoSetDimension(.height, toSize: width)
            layoutMargins += UIEdgeInsets(bottom: width)
        default:
            break
        }
    }
    
}
