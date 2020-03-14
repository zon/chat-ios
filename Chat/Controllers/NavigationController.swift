import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    init() {
        super.init(rootViewController: TopicsController())
    }
    
    override func viewDidLoad() {
        setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
