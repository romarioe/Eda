//
//  OrderViewController.swift
//  Eda
//
//  Created by Roman Efimov on 10.08.2022.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderStatus: UIButton!
    
    private let presenter = OrderPresenter()
    weak private var  orderOutputDelegate: OrderOutputDelegate?

    var orderModel: ResponseModel?
    
    
    @IBOutlet weak var orderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderStatus.isEnabled = false
        guard let orderModel = orderModel else {return}
        orderNumber.text = "Заказ №" + orderModel.number
        orderDate.text = orderModel.dateCreated
        
        orderStatus.layer.cornerRadius = 15

        presenter.setOrderInputDelegate(orderInputDelegate: self)
        self.orderOutputDelegate = presenter
        
        self.orderOutputDelegate?.checkOrderStatus(id: orderModel.id)
        
        let status = orderModel.status
        setStatus(status: status)
    }
    
    
    func setStatus(status: String){
        
        DispatchQueue.main.async {
            switch status {
            case "trash":
                self.orderStatus.setTitle("В архиве", for: .normal)
                self.orderStatus.backgroundColor = UIColor.lightGray
               
            case "processing":
                self.orderStatus.setTitle("Готовится", for: .normal)
                self.orderStatus.backgroundColor = UIColor.systemYellow
                
            case "completed":
                self.orderStatus.setTitle("Готово", for: .normal)
                self.orderStatus.backgroundColor = UIColor.green
                
                
            default:
                self.orderStatus.setTitle(status, for: .normal)
                self.orderStatus.backgroundColor = UIColor.lightGray
                
            }
        }
        }
   
    
    
    override func viewDidDisappear(_ animated: Bool) {
        self.orderOutputDelegate?.stopStatusUpdate()
    }
}





extension OrderViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderModel?.lineItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        cell.orderName.text = orderModel?.lineItems[indexPath.row].name
        cell.orderPrice.text = orderModel?.lineItems[indexPath.row].total

        return cell
    }
    
    
  
    
    
}



extension OrderViewController: OrderInputDelegate{
    func setOrderStatus(status: String) {
        setStatus(status: status)
    }
    
    
}
