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
    
    let viewModel = TaskEditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.setCircular()
        if viewModel.data != nil {
            nameTextField.text = viewModel.data.name
            descriptionTextField.text = viewModel.data.details
            datePicker.date = viewModel.data.date
        }
    }
    
    @IBAction func didSaveBtnClick(_ sender: Any) {
        let name = nameTextField.text
        let detail = descriptionTextField.text
        let date = datePicker.date
        if let name = name, let detail = detail {
            viewModel.saveEditedTask(name: name, detail: detail, date: date) { isSuccess in
                if isSuccess == "inserted" {
                    self.navigationController?.popViewController(animated: true)
                } else if isSuccess == "updated" {
                    self.navigationController?.popViewController(animated: true)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Task not added.")
                }
            }
        }
    }
}
