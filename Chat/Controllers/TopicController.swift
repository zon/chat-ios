import Foundation
import UIKit

class TopicController: UIViewController {
    let layout = TopicLayout()
    let topic: Topic
    
    private var editingId: UUID?
    
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
        table.scrollToRow(at: IndexPath(row: topic.messages.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    struct MessageData {
        let message: Message
        var editing: Bool = false
    }
    
}

extension TopicController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
        let message = topic.messages[indexPath.item]
        cell.setup(
            index: indexPath,
            message: message,
            isEditing: message.id == editingId
        )
        cell.delegate = self
        return cell
    }
    
}

extension TopicController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (_, _, complete) in
            guard let cell = self.table.cellForRow(at: indexPath) as? MessageCell else {
                complete(false)
                return
            }
            self.showEdit(cell: cell)
            complete(true)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, complete) in
            print("DELETE")
            complete(true)
        }
        
        return UISwipeActionsConfiguration(actions: [edit, delete])
    }
    
}

extension TopicController: MessageCellDelegate {
    
    func onCancel(cell: MessageCell) {
        hideEdit(cell: cell)
    }
    
    func onSave(cell: MessageCell) {
        guard
            let index = cell.index,
            let text = cell.body.text
        else { return }
        topic.messages[index.row].content = text
        hideEdit(cell: cell)
    }
    
    func showEdit(cell: MessageCell) {
        guard let index = cell.index, let message = cell.message else { return }
        editingId = message.id
        reloadRows()
        if let cell = table.cellForRow(at: index) as? MessageCell {
            cell.body.becomeFirstResponder()
        }
        layout.hideInput()
    }
    
    func hideEdit(cell: MessageCell) {
        editingId = nil
        reloadRows()
        layout.showInput()
    }
    
    func reloadRows() {
        let paths = (0..<topic.messages.count).map { IndexPath(row: $0, section: 0) }
        table.reloadRows(at: paths, with: .automatic)
    }
    
}
