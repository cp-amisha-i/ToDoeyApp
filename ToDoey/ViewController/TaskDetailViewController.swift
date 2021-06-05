//
//  TaskDetailViewController.swift
//  ToDoey
//
//  Created by Amisha I on 03/06/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDetail: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var dataSourceDB: TaskDataSource!
    var data: Task!
    var rowId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
    }
    
    func showData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        taskName.text = data.name
        taskDetail.text = data.details
        date.text = formatter.string(from: data.date)
        status.text = data.status
    }

    @IBAction func onEditClick(_ sender: Any) {
        let vm = TaskEditViewController()
        vm.dataSourceDB = dataSourceDB
        vm.data = data
        self.navigationController?.pushViewController(vm, animated: true)
    }
    
    
}
