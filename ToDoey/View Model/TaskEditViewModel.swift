//
//  TaskEditViewModel.swift
//  ToDoey
//
//  Created by Amisha I on 09/06/21.
//

import Foundation

class TaskEditViewModel {
    
    var dataSourceDB: TaskDataSource!
    var data: Task!
    var tasks: [Task]?
    var datas: [Task]?
    
    func saveEditedTask(name: String, detail: String, date: Date, completion: (String) -> ()) {
        if datas?.count == 0 {
            let result = dataSourceDB.insert(name: name, detailDesc: detail)
            if result != -1 {
                let task = Task(id: result ?? 1, name: name, detail: detail, date: date, status: "InComplete")
                self.tasks?.append(task)
                completion("inserted")
            } else {
                completion("")
            }
        } else {
            let result = dataSourceDB.update(id: data.id ?? 1, name: name, detailDesc: detail, date: date, status: data.status)
            if result {
                let id = data.id
                self.tasks?[Int(id! - 1)] = Task(id: id!, name: name, detail: detail, date: date, status: data.status)
                completion("updated")
            }
        }
    }
    
}
