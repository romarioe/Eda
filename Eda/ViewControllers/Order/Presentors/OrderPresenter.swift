//
//  OrderPresenter.swift
//  Eda
//
//  Created by Roman Efimov on 10.08.2022.
//

import Foundation

class OrderPresenter{
    
    weak private var orderInputDelegate: OrderInputDelegate?
    var timer = Timer()
    var networkService = NetworkService()
    var id = 0
    
    
    
    
    
    func setOrderInputDelegate(orderInputDelegate: OrderInputDelegate?){
        self.orderInputDelegate = orderInputDelegate
    }
    
    
    
    func scheduledTimerWithTimeInterval(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            print ("tick")
            self.loadUpdateStatus(id: self.id)
        })
    }
    

    
    func loadUpdateStatus(id: Int){
        
        networkService.checkStatus(id: id) { updateResponseItem in
            guard let updateResponseItem = updateResponseItem else {return}
            print (updateResponseItem.status)
            self.orderInputDelegate?.setOrderStatus(status: updateResponseItem.status)
        }
    }
}



extension OrderPresenter: OrderOutputDelegate{
    func stopStatusUpdate() {
        timer.invalidate()
    }
    
   
    
    func checkOrderStatus(id: Int) {
        self.id = id
        scheduledTimerWithTimeInterval()
    }
    
    
}
