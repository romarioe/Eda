//
//  OrderTableViewCell.swift
//  Eda
//
//  Created by Roman Efimov on 10.08.2022.
//


import UIKit

class OrderTableViewCell: UITableViewCell {
    

    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    
    
  
    
    

}
