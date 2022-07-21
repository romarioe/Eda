//
//  MenuTableViewCell.swift
//  Eda
//
//  Created by Roman Efimov on 14.07.2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    


    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuDescription: UILabel!    
    @IBOutlet weak var menuPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        menuPrice.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
