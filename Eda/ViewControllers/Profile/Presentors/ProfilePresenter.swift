//
//  ProfilePresenter.swift
//  Eda
//
//  Created by Roman Efimov on 05.08.2022.
//

import Foundation
import RealmSwift

class ProfilePresenter{
    
    
    let realm = try! Realm()
    var userModel: Results<UserModel>!    
    var orderModel: Results<OrderRealmModel>!
    
    var responseModel: [ResponseModel] = []
    var updateResponseModel: [ResponseModel] = []
    
    var networkService = NetworkService()
    var orderService = OrderService()
    
    var timer = Timer()
    
    
    
    weak private var profileInputDelegate: ProfileInputDelegate?
    
    
    
    func setProfileInputDelegate(profileInputDelegate: ProfileInputDelegate?){
        self.profileInputDelegate = profileInputDelegate
    }
    
    
//    func scheduledTimerWithTimeInterval(){
//        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
//            //self.loadDataFromRealm()
//            self.loadUpdateStatus()
//           })
//    }
    
    
    
    func loadDataFromRealm(){
        orderModel = realm.objects(OrderRealmModel.self)
        responseModel.removeAll()
        checkStatus()
    }
    
    
    
    func checkStatus(){
        orderModel = realm.objects(OrderRealmModel.self)
        let count = orderModel.count
        for item in orderModel {
            networkService.checkStatus(id: item.id) { responseItem in
                guard let responseItem = responseItem else {return}
                self.responseModel.append(responseItem)
                
                if self.responseModel.count == count {
                    self.sortResponseModel(responseModel: self.responseModel)
                    self.profileInputDelegate?.setOrders(responseModel: self.responseModel)
                }
            }
        }
    }
    
    
    
    
    
//    func loadUpdateStatus(){
//        orderModel = realm.objects(OrderRealmModel.self)
//        updateResponseModel.removeAll()
//        let count = orderModel.count
//        for item in orderModel {
//            networkService.checkStatus(id: item.id) { updateResponseItem in
//                guard let updateResponseItem = updateResponseItem else {return}
//                self.updateResponseModel.append(updateResponseItem)
//
//                if self.updateResponseModel.count == count {
//                    self.checkUpdateStatus()
//                }
//            }
//        }
//    }
//
    
    
    
    
//    func checkUpdateStatus(){
//        self.sortResponseModel(responseModel: updateResponseModel)
//        print ("Tick")
//
//        //print ("Update = ", updateResponseModel)
//        //print ("Response = ", responseModel)
//
//        for (index, _) in updateResponseModel.enumerated() {
//            if updateResponseModel[index].status != responseModel[index].status{
//                print ("Old = ", responseModel[index].status)
//                print ("New = ", updateResponseModel[index].status)
//
//            }
//        }
//
//    }
//
    
    func sortResponseModel(responseModel: [ResponseModel]){
        self.responseModel = responseModel.sorted(by: { $0.number > $1.number })
    }
    
    
}



extension ProfilePresenter: ProfileOutputDelegate{
    func getUser() {
        userModel = realm.objects(UserModel.self)
        if !userModel.isEmpty {
            let name = userModel[0].name + " " + userModel[0].lastName
            let phone = userModel[0].phone
            let address = userModel[0].city + " " + userModel[0].street + ", " + userModel[0].house + " кв. " + userModel[0].flat
            
            self.profileInputDelegate?.setUser(name: name, phone: phone, address: address)
        }
    }
    
    func removeOrder(number: String) {
        self.orderService.removeFromOrders(number: number)
    }
    
    
    func getOrders() {
        loadDataFromRealm()
       
    }
    
}
