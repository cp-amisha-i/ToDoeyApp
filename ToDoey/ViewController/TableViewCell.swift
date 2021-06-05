//
//  TableViewCell.swift
//  ToDoey
//
//  Created by Amisha I on 03/06/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tickButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var dataSourceDB: TaskDataSource!
    var rowId: Int64!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func onClickTickButton(_ sender: UIButton) {
        if tickButton.tintColor != .cyan {
            let result = dataSourceDB.updateStatus(id: rowId, status: "Complete")
            if result {
                tickButton.tintColor = .cyan
            }
        } else {
            let result = dataSourceDB.updateStatus(id: rowId, status: "InComplete")
            if result {
                tickButton.tintColor = .lightGray
            }
        }
    }
}
