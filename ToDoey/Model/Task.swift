//
//  Task.swift
//  ToDoey
//
//  Created by Amisha I on 03/06/21.
//

import Foundation

class Task {
    let id: Int64?
    var name: String
    var details: String?
    var date: Date
    var status: String
    
    init(id: Int64) {
        self.id = id
        name = ""
        details = ""
        date = Date()
        status = ""
    }
    
    init(id: Int64, name: String, detail: String?, date: Date, status: String) {
        self.id = id
        self.name = name
        self.details = detail
        self.date = date
        self.status = status
    }
}
