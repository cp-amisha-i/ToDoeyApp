//
//  ViewController.swift
//  ToDoey
//
//  Created by Amisha I on 03/06/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    let dataSourceDB = TaskDataSource()
    var tasks: [Task] = []
    var data: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataSourceDB.createDatabase()
        dataSourceDB.createTable()
        
        prepairTableview()
        addButton.layer.cornerRadius = addButton.frame.size.height / 2
        tasks = dataSourceDB.getAllData() ?? []
    }
    
    func prepairTableview() {
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: .main), forCellReuseIdentifier: "mainCell")
        self.tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tasks = dataSourceDB.getAllData() ?? []
        tableView.reloadData()
    }
    
    @IBAction func onAddButtonClick(_ sender: UIButton) {
        let vm = TaskEditViewController()
        vm.dataSourceDB = dataSourceDB
        vm.tasks = tasks
        vm.datas = data
        self.navigationController?.pushViewController(vm, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! TableViewCell
        if tasks.count != 0 {
            cell.titleLabel.text = tasks[indexPath.row].name
            cell.dataSourceDB = dataSourceDB
            cell.rowId = Int64(indexPath.row + 1)
            
        } else {
            cell.titleLabel.text = "No Task Added."
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vm = TaskDetailViewController()
        vm.dataSourceDB = dataSourceDB
        vm.rowId = indexPath.row
        vm.data = dataSourceDB.getData(id: Int64(indexPath.row + 1))
        self.navigationController?.pushViewController(vm, animated: true)
    }
    
//    For delete on swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let result = dataSourceDB.delete(id: tasks[indexPath.row].id!)
            if result > 0 {
                tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        }
    }
}

