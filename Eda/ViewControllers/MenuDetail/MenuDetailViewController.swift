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
    var selectedOption = ""
    var price = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.layer.cornerRadius = 25
        closeButton.dropShadow()
        
        guard let menuDetail = menuDetail else {return}
                
        if let imageURL = URL(string: menuDetail.imageLink) {
            detailImage.sd_setImage(with: imageURL)
        }
        
        setSegmentControl()
        
        detailName.text = menuDetail.name
        detailDescription.text = menuDetail.description
        orderButton.setTitle("В корзину за "+menuDetail.price[0]+"₽", for: .normal)
    }
    
    
    
    func setSegmentControl(){
        guard let menuDetail = menuDetail else {return}
      
        let filtersSegment = UISegmentedControl(items: menuDetail.options)
        let frame = UIScreen.main.bounds
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        if screenSize.height < 650 {
            filtersSegment.frame = CGRect.init(x: frame.width/2-150, y: frame.height-120, width: 300, height: 40)
        } else {
            filtersSegment.frame = CGRect.init(x: frame.width/2-150, y: frame.height-180, width: 300, height: 40)
        }
        
      
        
        //filtersSegment.frame = CGRect.init(x: frame.width/2-150, y: frame.height-130, width: 300, height: 40)
        filtersSegment.selectedSegmentIndex = 0
        filtersSegment.tintColor = UIColor.black
        filtersSegment.addTarget(self, action: #selector(self.filterApply), for: UIControl.Event.valueChanged)
        self.view.addSubview(filtersSegment)


    }
    
    
    @objc private func filterApply(segment: UISegmentedControl) -> Void {
        guard let menuDetail = menuDetail else {return}
        switch segment.selectedSegmentIndex {
        case 0:
            let isIndexValid = menuDetail.price.indices.contains(0)
            if isIndexValid {
                orderButton.setTitle("В корзину за "+menuDetail.price[0]+"₽", for: .normal)
                price = menuDetail.price[0]
            }
            
        case 1:
            selectedOption = segment.titleForSegment(at: 1) ?? ""
            let isIndexValid = menuDetail.price.indices.contains(1)
            if isIndexValid {
                orderButton.setTitle("В корзину за "+menuDetail.price[1]+"₽", for: .normal)
                price = menuDetail.price[1]
            }
        case 2:
            selectedOption = segment.titleForSegment(at: 2) ?? ""
            let isIndexValid = menuDetail.price.indices.contains(2)
            if isIndexValid {
                orderButton.setTitle("В корзину за "+menuDetail.price[2]+"₽", for: .normal)
                price = menuDetail.price[2]
            }
        case 3:
            
            let isIndexValid = menuDetail.price.indices.contains(3)
            if isIndexValid {
                orderButton.setTitle("В корзину за "+menuDetail.price[3]+"₽", for: .normal)
                price = menuDetail.price[3]
            }
        case 4:
            
            let isIndexValid = menuDetail.price.indices.contains(4)
            if isIndexValid {
                orderButton.setTitle("В корзину за "+menuDetail.price[4]+"₽", for: .normal)
                price = menuDetail.price[4]
            }
        case 5:
            
            let isIndexValid = menuDetail.price.indices.contains(4)
            if isIndexValid {
                orderButton.setTitle("В корзину за "+menuDetail.price[5]+"₽", for: .normal)
                price = menuDetail.price[5]
            }
        case 6:
            let isIndexValid = menuDetail.price.indices.contains(6)
            if isIndexValid {
                orderButton.setTitle("В корзину за "+menuDetail.price[6]+"₽", for: .normal)
                price = menuDetail.price[6]
            }
        default:
            selectedOption = ""
        }
    }
    

  
    @IBAction func orderButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addToCart(_ sender: Any) {
        let comment = selectedOption
        guard let menuDetail = menuDetail else {return}
        
        guard let price = Int(self.price) else {return}
        cartService.addToCart(id: menuDetail.id, name: menuDetail.name, conut: 1, price: price, comment: comment, imageLink: menuDetail.imageLink)
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
