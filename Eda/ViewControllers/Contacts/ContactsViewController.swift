//
//  ContactsViewController.swift
//  Eda
//
//  Created by Roman Efimov on 18.07.2022.
//

import UIKit
import MapKit

class ContactsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var contactsTableView: UITableView!
    
    let contactsArray = ["Краснооктябрьская, 45",  "+7 (928) 463 45 36", "Мы работаем с 9 до 21 часа", "Доставка возможна с 10 до 20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMap()
    }
    
    
    func setupMap(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 44.606993, longitude: 40.102223)
        annotation.title = "Еда"
        annotation.subtitle = "Открыто с 9 до 21"
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
   
    


}



extension ContactsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = contactsArray[indexPath.row]
        return cell
    }
    
    
}
