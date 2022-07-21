//
//  MenuDetailViewController.swift
//  Eda
//
//  Created by Roman Efimov on 15.07.2022.
//

import UIKit
import SDWebImage

class MenuDetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var menuDetail: MenuDetail?
    
    var cartService = CartService()

    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.layer.cornerRadius = 25
        
        guard let menuDetail = menuDetail else {return}
                
        if let imageURL = URL(string: menuDetail.imageLink) {
            detailImage.sd_setImage(with: imageURL)
        }
       
        detailName.text = menuDetail.name
        detailDescription.text = menuDetail.description
        orderButton.setTitle("В корзину за "+menuDetail.price+"₽", for: .normal)
    }
    

  
    @IBAction func orderButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addToCart(_ sender: Any) {
        guard let menuDetail = menuDetail else {return}
        guard let price = Int(menuDetail.price) else {return}
        cartService.addToCart(name: menuDetail.name, conut: 1, price: price, comment: "", imageLink: menuDetail.imageLink)
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
