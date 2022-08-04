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
    var cartModel: Results<CartModel5>!
    var cartService = CartService()
    var orderService = OrderService()
    let networkService = NetworkService()
    
    var cart: [OrderItem] = []


    @IBOutlet weak var clButton: UIButton!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var sendOrder: UIButton!
    @IBOutlet weak var cartHeader: UILabel!
    @IBOutlet weak var removeAllCartButton: UIButton!
    
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendOrder.layer.cornerRadius = 15
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.items?[2].badgeValue = nil
        loadDataFromRealm()
        loadCartArray()
        updateUI()
    }
    
    
    func showActivityIndicator(){
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    
    func loadCartArray(){
        cart.removeAll()
        for item in cartModel{
            let cartItem = OrderItem(id: item.id, quantity: item.count)
            cart.append(cartItem)
        }
    }
    
    
    func loadDataFromRealm(){
        
        cartModel = realm.objects(CartModel5.self)
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
        updateUI()
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
        
    }
    
    
    func updateUI(){
        if cartModel.isEmpty{
            sendOrder.isEnabled = false
            sendOrder.isHidden = true
            cartHeader.text = "     В вашей корзине пока нет заказов..."
            removeAllCartButton.isEnabled = false
            removeAllCartButton.isHidden = true
        } else {
            sendOrder.isEnabled = true
            sendOrder.isHidden = false
            cartHeader.text = ""
            removeAllCartButton.isEnabled = true
            removeAllCartButton.isHidden = false
        }
        let buttonTitle = cartService.getTotalPrice()
        sendOrder.setTitle("Оплатить " + String(buttonTitle) + "₽", for: .normal)
    }
    
    
    
    @IBAction func sendOrder(_ sender: Any) {
        showActivityIndicator()
        networkService.postOrder(items: cart) { response in
            guard let response = response else {return}
            DispatchQueue.main.async { [self] in
                self.orderService.addToOrders(id: response.id)
                self.removeAllCart()
                activityIndicator.stopAnimating()
            }
            
           
        }
    }
    
    
    
    
    

    
    
    
    
    
}



extension CartViewController: UITableViewDelegate, UITableViewDataSource, ChangeCountProtocol{
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
        cell.comment.text = cartModel[indexPath.row].comment
        if let imageURL = URL(string: cartModel[indexPath.row].imageLink) {
            cell.cartImage.sd_setImage(with: imageURL)
        } else {
            cell.cartImage.image = UIImage(systemName: "slowmo")
        }
        
       
        
        return cell
    }
    
    
    func changeCountButtonPressed() {
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
        loadCartArray()
        updateUI()
    }

    
    
}




protocol ChangeCountProtocol: AnyObject {
    func changeCountButtonPressed()
}
