//
//  TaskDataSource.swift
//  ToDoey
//
//  Created by Amisha I on 03/06/21.
//

import Foundation
import SQLite

class TaskDataSource {
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    var db: Connection? = nil
    let tasks = Table("tasks")
    
    let id = Expression<Int64>("id")
    let taskName = Expression<String?>("taskName")
    let details = Expression<String?>("details")
    let date = Expression<Date>("date")
    let status = Expression<String>("status")
    
    func createDatabase() {
        do {
            db = try Connection("\(path)/db.sqlite3")
            print(path)
        } catch {
            print(error)
        }
    }
    
    func createTable() {
        guard let database = db else {
            return
        }
        do {
            try database.run(tasks.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(taskName)
                table.column(details)
                table.column(date)
                table.column(status)
            })
            print("Create Table...")
        } catch {
            print(error)
        }
    }

    func insert(name: String, detailDesc: String? = nil, date: Date = Date(), status: String = "InComplete") -> Int64? {
        
        var rowId: Int64 = 1
        let insert = tasks.insert(self.taskName <- name, self.details <- detailDesc, self.date <- date, self.status <- status)
        guard let database = db else {
            return nil
        }
        do {
            rowId = try database.run(insert)
        } catch {
            print(error)
        }
        return rowId
    }

    func getName() -> [String]? {
        var dbData: [String] = []
        guard let database = db else {
            return nil
        }
        do {
            for task in try database.prepare(tasks) {
                dbData.append(task[taskName]!)
            }
        } catch {
            print(error)
        }
        return dbData
    }
    
    func getData(id: Int64) -> Task? {
        let data: Task = Task(id: id)
        
        guard let database = db else {
            return nil
        }
        //let query = tasks.select(id, taskName, details, status)
        let query = tasks.filter(self.id == id)
        do {
            for d in try database.prepare(query) {
                data.name = d[taskName]!
                data.details = d[details]
                data.date = d[date]
                data.status = d[status]
            }
            
        } catch {
            print(error)
        }
        
        return data
    }
    
    func getAllData() -> [Task]? {
        
        var tasks = [Task]()
        
        guard let database = db else {
            return nil
        }
        
        do {
            for task in try database.prepare(self.tasks) {
                tasks.append(Task(id: task[id], name: task[taskName] ?? "None", detail: task[details], date: task[date], status: task[status]))
            }
        } catch {
            print(error)
        }
        return tasks
    }
    
    func delete(id: Int64) -> Int {
        var tid: Int = 0
        let teamId = tasks.filter(self.id == id)
        guard let database = db else {
            return 0
        }
        do {
            tid = try database.run(teamId.delete())
        } catch {
            print(error)
        }
        return tid
    }
    
    func update(id: Int64, name: String, detailDesc: String? = nil, date: Date = Date(), status: String = "InComplete") -> Bool {
        
        let task = tasks.filter(self.id == id)
        guard let database = db else {
            return false
        }
        do {
            let update = task.update([
                taskName <- name,
                details <- detailDesc,
                self.date <- date,
                self.status <- status
            ])
            if try database.run(update) > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    func updateStatus(id: Int64, status: String) -> Bool {
        guard let database = db else {
            return false
        }
        let task = tasks.filter(self.id == id)
        do {
            let update = task.update(self.status <- status)
            if try database.run(update) > 0 {
                print("Update status successfully.")
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
}
