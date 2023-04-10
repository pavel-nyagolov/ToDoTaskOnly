//
//  TaskDoneButton.swift
//  ToDoTask
//
//  Created by Pavel on 10.04.23.
//

import UIKit

@IBDesignable
class TaskDoneButton: CircleButton {
    
    var isDone: Bool = false {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func configure() {
        if isDone {
            layer.backgroundColor = UIColor.green.cgColor
            layer.borderWidth = 2
            layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            layer.backgroundColor = UIColor.lightGray.cgColor
            layer.borderWidth = 2
            layer.borderColor = UIColor.gray.cgColor
        }
    }
}
