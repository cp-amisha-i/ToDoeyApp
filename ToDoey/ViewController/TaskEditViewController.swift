//
//  TaskEditViewController.swift
//  ToDoey
//
//  Created by Amisha I on 03/06/21.
//

import UIKit

class TaskEditViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    var dataSourceDB: TaskDataSource!
    var data: Task!
    var tasks: [Task]?
    var datas: [Task]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if data != nil {
            nameTextField.text = data.name
            descriptionTextField.text = data.details
            datePicker.date = data.date
        }
    }
    
    @IBAction func didSaveBtnClick(_ sender: Any) {
        let name = nameTextField.text
        let detail = descriptionTextField.text
        let date = datePicker.date
        if let name = name, let detail = detail {
            
            if datas?.count == 0{
                let result = dataSourceDB.insert(name: name, detailDesc: detail)
                if result != -1 {
                    let task = Task(id: result ?? 1, name: name, detail: detail, date: date, status: "InComplete")
                    self.tasks?.append(task)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Task not added.")
                }
            } else {
                let result = dataSourceDB.update(id: data.id ?? 1, name: name, detailDesc: detail, date: date, status: data.status)
                if result {
                    let id = data.id
                    self.tasks?[Int(id! - 1)] = Task(id: id!, name: name, detail: detail, date: date, status: data.status)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
