import Foundation
import UIKit

class TopicController: UIViewController {
    let layout = TopicLayout()
    let topic: Topic
    
    var collection: UICollectionView {
        get {
            return layout.collection
        }
    }
    
    init(topic: Topic) {
        self.topic = topic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
    }
    
    override func viewDidLoad() {
        collection.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        layout.back.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layout.setup(topic: topic)
        collection.reloadData()
    }
    
    @objc func onTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension TopicController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topic.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
        let message = topic.messages[indexPath.item]
        cell.setup(message: message)
        return cell
    }
    
}

extension TopicController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = topic.messages[indexPath.item]
        return MessageCell.estimate(message: message)
    }
    
}
