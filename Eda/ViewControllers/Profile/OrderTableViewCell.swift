//
//  OrderTableViewCell.swift
//  Eda
//
//  Created by Roman Efimov on 28.07.2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var statusButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusButton.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
