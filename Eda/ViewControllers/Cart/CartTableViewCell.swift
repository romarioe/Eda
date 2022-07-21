//
//  CartTableViewCell.swift
//  Eda
//
//  Created by Roman Efimov on 18.07.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartName: UILabel!
    @IBOutlet weak var cartPrice: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    
    @IBOutlet weak var incCount: UIButton!
    @IBOutlet weak var decCount: UIButton!
    
    var priceInt: Int = 0
    
    var cartService = CartService()
    
    
    weak var delegate: DailySpeakingLessonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        incCount.tintColor = #colorLiteral(red: 0.9417033245, green: 0.7470910757, blue: 0.1306448477, alpha: 1)
        decCount.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func incCount(_ sender: Any) {
       // let priceStr = cartPrice.text?.removeLast()
       // let price = Int(priceStr)
        
        cartService.addToCart(name: cartName.text ?? "", conut: 1, price: priceInt, comment: "", imageLink: "")
        delegate?.dailySpeakingLessonButtonPressed()
    }
    
    
    @IBAction func decCount(_ sender: Any) {
        cartService.removeFromCart(name: cartName.text ?? "", price: priceInt)
        delegate?.dailySpeakingLessonButtonPressed()
    }
    
    
    
    
  
    
    

}
