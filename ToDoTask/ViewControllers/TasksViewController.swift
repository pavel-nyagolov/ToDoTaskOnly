//
//  ViewController.swift
//  ToDoTask
//
//  Created by Pavel on 10.04.23.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var isEditingClicked = false
    var tasks: [TaskModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .updateTasks, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.updateData()
        }
        
        updateData()
    }
    
    func updateData() {
        guard let newTasks = FactoryStorage.getTasks() else {
            return
        }
        tasks = newTasks
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        let task = TaskModel()
        task.text = "Enter new task"
        FactoryStorage.addTask(task)
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        if !isEditingClicked {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            isEditingClicked = true
        } else {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            isEditingClicked = false
        }
    }
    
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tasks.isEmpty {
            let label = UILabel()
            label.text = "No Tasks"
            label.textColor = .white
            label.textAlignment = .center
            tableView.backgroundView = label
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks.isEmpty {
            let label = UILabel()
            label.text = "No Tasks"
            label.textColor = .white
            label.textAlignment = .center
            tableView.backgroundView = label
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.taskCell) as? TaskCell else {
            return UITableViewCell()
        }
        let task = tasks[indexPath.section]
        cell.taskTextField.text = task.text
        cell.taskButton.isDone = task.isDone
        
        cell.textChangedHandler = { (text) in
            try? FactoryStorage.realm.write {
                task.text = text
            }
        }
        
        cell.taskHandler = {
            try? FactoryStorage.realm.write {
                if task.isDone {
                    task.isDone = false
                    cell.taskButton.isDone = false
                } else {
                    task.isDone = true
                    cell.taskButton.isDone = true
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TaskCell else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        let task = tasks[indexPath.section]
        try? FactoryStorage.realm.write {
            if task.isDone {
                task.isDone = false
                cell.taskButton.isDone = false
            } else {
                task.isDone = true
                cell.taskButton.isDone = true
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        FactoryStorage.deleteTask(tasks[indexPath.section])
    }
    
    
}
