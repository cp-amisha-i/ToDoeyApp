//
//  TableCellViewModel.swift
//  ToDoey
//
//  Created by Amisha I on 09/06/21.
//

import Foundation

class TableCellViewModel {
    
    var dataSourceDB: TaskDataSource!
    var rowId: Int64!
    
    func updateTask(status: Bool, completion: (Bool) -> ()) {
        let statusValue = status ? "Complete" : "InComplete"
        let result = dataSourceDB.updateStatus(id: rowId, status: statusValue)
        if result {
            completion(true)
        }
    }
}
