//
//  CartViewController.swift
//  Eda
//
//  Created by Roman Efimov on 18.07.2022.
//

import UIKit
import RealmSwift
import SDWebImage

class CartViewController: UIViewController {
    
    let realm = try! Realm()
    var cartModel: Results<CartModel4>!
    var cartService = CartService()


    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartHeader: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.items?[2].badgeValue = nil
        loadDataFromRealm()
    }
    
    
    func loadDataFromRealm(){
        cartModel = realm.objects(CartModel4.self)
        if cartModel.count == 0 {
            cartHeader.text = "     В вашей корзине пока нет заказов..."
        } else {
            cartHeader.text = ""
        }
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
    
    
    
    @IBAction func removeAllCart(_ sender: Any) {

            let alert = UIAlertController(title: "Удалить все заказы из корзины?", message: "", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "Да", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in self.removeAllCart()
            })
            alert.addAction(ok)
            ok.setValue(#colorLiteral(red: 0.9417033245, green: 0.7470910757, blue: 0.1306448477, alpha: 1), forKey: "titleTextColor")
            
            let cancel = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(cancel)
            cancel.setValue(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), forKey: "titleTextColor")
            self.present(alert, animated: true, completion: nil)

    }
    
    
    
    func removeAllCart(){
        self.cartService.removeAllCart()
        cartHeader.text = "     В вашей корзине пока нет заказов..."
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
        
    }
    
    
    
}



extension CartViewController: UITableViewDelegate, UITableViewDataSource, DailySpeakingLessonDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.delegate = self
        cell.priceInt = cartModel[indexPath.row].price
        cell.cartName.text = cartModel[indexPath.row].name
        cell.cartPrice.text = String(cartModel[indexPath.row].totalPrice)+"₽"
        cell.cartCount.text = String(cartModel[indexPath.row].count)
        print ("Image = ", cartModel[indexPath.row].imageLink)
        if let imageURL = URL(string: cartModel[indexPath.row].imageLink) {
            cell.cartImage.sd_setImage(with: imageURL)
        } else {
            cell.cartImage.image = UIImage(systemName: "slowmo")
        }
        
       
        
        return cell
    }
    
    
    func dailySpeakingLessonButtonPressed() {
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }

    
    
}




protocol DailySpeakingLessonDelegate: AnyObject {
    func dailySpeakingLessonButtonPressed()
}
