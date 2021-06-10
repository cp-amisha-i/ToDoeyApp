//
//  MainViewModel.swift
//  ToDoey
//
//  Created by Amisha I on 05/06/21.
//

import Foundation

class MainViewModel {
    
    let dataSourceDB = TaskDataSource()
    var tasks: [Task] = []
    
    func createDatabase() {
        dataSourceDB.createDatabase()
        dataSourceDB.createTable()
    }
    
    func getAllTasks() -> [Task] {
        dataSourceDB.getAllData() ?? []
    }
    
    func getSelectedTask(id: Int64) -> Task {
        dataSourceDB.getData(id: id)!
    }
    
    func deleteTask(id: Int64, completion: (Bool) -> ()) {
        let result = dataSourceDB.delete(id: id)
        if result > 0 {
            completion(true)
        }
    }
}
