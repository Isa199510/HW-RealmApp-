//
//  StorageManager.swift
//  RealmApp
//
//  Created by Alexey Efimov on 08.10.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Task List
    func save(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save(_ taskList: String, completion: (TaskList) -> Void) {
        write {
            let taskList = TaskList(value: [taskList])
            realm.add(taskList)
            completion(taskList)
        }
    }
    
    func save(_ task: Task, completion: (Task) -> Void) {
        write {
            let task = Task(value: [task])
            realm.add(task)
            completion(task)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    //my code
    func delete(_ task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func edit(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }
    
    // my code
    func edit(_ task: Task, newName: String, newNote: String) {
        write {
            task.name = newName
            task.note = newNote
        }
    }

    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }
    
    //my code
    func done(_ task: Task, isComplete: Bool, completion: () -> Void) {
        write {
            task.setValue(isComplete, forKey: "isComplete")
            completion()
        }
    }

    // MARK: - Tasks
    func save(_ task: String, withNote note: String, to taskList: TaskList, completion: (Task) -> Void) {
        write {
            let task = Task(value: [task, note])
            taskList.tasks.append(task)
            completion(task)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
