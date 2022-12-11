//
//  TaskListViewCell.swift
//  RealmApp
//
//  Created by Иса on 11.12.2022.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import UIKit

class TaskListViewCell: UITableViewCell {

    func configure(_ taskList: TaskList) {
        let currentTasks = taskList.tasks.filter("isComplete = false")
        var content = defaultContentConfiguration()
        content.text = taskList.name
        
        if taskList.tasks.isEmpty {
            content.secondaryText = "0"
            accessoryType = .none
        } else if currentTasks.isEmpty{
            accessoryType = .checkmark
        } else {
            content.secondaryText = "\(taskList.tasks.count)"
            accessoryType = .none
        }
        contentConfiguration = content
    }

}
