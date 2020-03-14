import Foundation
import UIKit

class TopicsController: UIViewController {
    let layout = TopicsLayout()
    
    var topics: [Topic] = []
    
    var collection: UICollectionView {
        get {
            return layout.collection
        }
    }
    
    override func loadView() {
        view = layout
    }
    
    override func viewDidLoad() {
        layout.create.addTarget(self, action: #selector(onTapCreate), for: .touchUpInside)
        collection.register(TopicCell.self, forCellWithReuseIdentifier: TopicCell.identifier)
        collection.dataSource = self
        collection.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topics = [
            Topic(name: "General"),
            Topic(name: "Games"),
            Topic(name: "Food"),
            Topic(name: "Events")
        ]
        collection.reloadData()
    }
    
    @objc func onTapCreate() {
        if layout.createOpen {
            layout.hideCreate()
        } else {
            layout.showCreate()
        }
    }
    
}

extension TopicsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: TopicCell.identifier, for: indexPath) as! TopicCell
        let topic = topics[indexPath.item]
        cell.setup(topic: topic)
        return cell
    }
    
}

extension TopicsController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 62
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = topics[indexPath.item]
        let controller = TopicController(topic: topic)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
