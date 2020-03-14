import Foundation
import UIKit

class TopicController: UIViewController {
    let layout = TopicLayout()
    let topic: Topic
    
    var table: UITableView {
        get {
            return layout.messages
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
        table.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
        table.dataSource = self
        table.delegate = self
        layout.back.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
        layout.send.addTarget(self, action: #selector(onSend), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layout.setup(topic: topic)
        table.reloadData()
    }
    
    @objc func onTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onSend() {
        guard
            let content = layout.input.text,
            !content.isEmpty,
            let user = topic.messages.first?.user
        else { return }
        let message = Message(user: user, content: content)
        topic.messages.append(message)
        
        layout.input.text = nil
        table.reloadData()
    }
    
}

extension TopicController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
        let message = topic.messages[indexPath.item]
        cell.setup(message: message)
        return cell
    }
    
}

extension TopicController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = topic.messages[indexPath.item]
        return MessageCell.estimate(message: message).height
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (_, _, complete) in
            print("EDIT")
            complete(true)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, complete) in
            print("DELETE")
            complete(true)
        }
        
        return UISwipeActionsConfiguration(actions: [edit, delete])
    }
    
}
