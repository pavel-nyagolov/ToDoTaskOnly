//
//  TaskCell.swift
//  ToDoTask
//
//  Created by Pavel on 10.04.23.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var taskButton: TaskDoneButton!
    
    var taskHandler: (() -> Void)?
    var textChangedHandler: ((String) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        taskTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func taskButtonTapped(_ sender: UIButton) {
        taskHandler!()
    }
}

extension TaskCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        textChangedHandler!(text)
        textField.resignFirstResponder()
        return true
    }
}
