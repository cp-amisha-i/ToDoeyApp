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
    
    let viewModel = TaskDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
        editButton.setCircular()
        editButton.setShadow()
        taskName.setCircular()
    }
    
    func showData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        taskName.text = viewModel.data.name
        taskDetail.text = viewModel.data.details
        date.text = formatter.string(from: viewModel.data.date)
        status.text = viewModel.data.status
    }

    @IBAction func onEditClick(_ sender: Any) {
        let vm = TaskEditViewController()
        vm.viewModel.dataSourceDB = viewModel.dataSourceDB
        vm.viewModel.data = viewModel.data
        self.navigationController?.pushViewController(vm, animated: true)
    }
    
    
}
