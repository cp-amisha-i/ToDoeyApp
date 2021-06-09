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
    
    let viewModel = TableCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onClickTickButton(_ sender: UIButton) {
        if tickButton.tintColor != .cyan {
            viewModel.updateTask(status: true) { isUpdate in
                tickButton.tintColor = .cyan
            }
        } else {
            viewModel.updateTask(status: false) { isUpdate in
                tickButton.tintColor = .lightGray
            }
        }
    }
}
