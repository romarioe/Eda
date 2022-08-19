//
//  MenuViewController.swift
//  Eda
//
//  Created by Roman Efimov on 14.07.2022.
//

import UIKit
import SDWebImage

class MenuViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!
    
    private let presenter = MenuPresenter()
    weak private var  menuOutputDelegate: MenuOutputDelegate?
    
    private var categories: [Categories]?
    private var menu: [Menu]?
    private var activeCategory: String = ""
    
    private var menuDetail: MenuDetail?
    
    var totalPrice: Int = 0
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.setMenuInputDelegate(menuInputDelegate: self)
        self.menuOutputDelegate = presenter
        self.menuOutputDelegate?.getMenu()
       
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showActivityIndicator(){
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    
    
    func setupUI(){
        showActivityIndicator()
        phoneButton.layer.cornerRadius = 15
        phoneButton.dropShadow()
    
        profileButton.layer.cornerRadius = 15
        profileButton.dropShadow()
        
        tabBarController?.tabBar.tintColor = UIColor.black
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.darkGray
    }
    
    
    @IBAction func callButton(_ sender: Any) {
        callNumber(phoneNumber: "88005553535")
    }
    
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuDetailSegue" {
            let destinationVC = segue.destination as! MenuDetailViewController
            destinationVC.menuDetail = menuDetail
        }
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        self.menuOutputDelegate?.getTotalPrice()
    }
    
    



}


extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryName.text = categories?[indexPath.row].name ?? ""
        cell.layer.cornerRadius = 15
        
        if indexPath.row == 0 && activeCategory == "" {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        } else {
            
            if categories?[indexPath.row].name == activeCategory{
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                
            } else {
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9417033245, green: 0.7470910757, blue: 0.1306448477, alpha: 1)
            }
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row > 0 {
            var position = 0
            guard let categories = categories else {return}
            activeCategory = categories[indexPath.row].name
            for i in 0...indexPath.row-1{
                position = position+categories[i].count
            }
                
            menuTableView.scrollToRow(at: [0,position], at: .top, animated: true)
            print ("Position = ", position)
        } else {
            guard let categories = categories else {return}
            let indexPath = IndexPath(item: 0, section: 0)
            activeCategory = categories[indexPath.row].name
            menuTableView.scrollToRow(at: [0,0], at: .top, animated: true)
        }
        scrollCategoryToSelection(activeCategory: activeCategory)
    }
}




extension MenuViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        let cellRect = CGRect(x: 0, y: 0, width: menuTableView.frame.size.width, height: 120)
        cell.frame = cellRect
        cell.selectionStyle = .none
        

        if let menu = menu {
        
            cell.menuName.text = menu[indexPath.row].name
            cell.menuPrice.text = menu[indexPath.row].price + "₽"
            let description =  menu[indexPath.row].description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            cell.menuDescription.text = description
            if let imageURL = URL(string: menu[indexPath.row].images[0].src) {
                cell.menuImage.sd_setImage(with: imageURL)
            } else {
                cell.menuImage.image = UIImage(systemName: "slowmo")
            }
            
    }
        return cell
    }
    

    
 
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView is UITableView {
            startScroll()
        }
    }
    
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView is UITableView {
            startScroll()
        }
    }
    
    
    
    func startScroll(){
        let firstVisibleIndexPath = menuTableView.indexPathsForVisibleRows?[1]
        guard let menu = menu else {return}
        scrollCategoryToSelection(activeCategory: menu[firstVisibleIndexPath!.row].categories[0].name)
    }
    
    
        
    func scrollCategoryToSelection(activeCategory: String){
        self.activeCategory = activeCategory
        guard let categories = categories else {return}
        
        for (index, value) in categories.enumerated(){
            if value.name == activeCategory {
                let indexPath = IndexPath(item: index, section: 0)
                
                self.categoryCollectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: false)
                
                DispatchQueue.main.async {
                    self.categoryCollectionView.reloadData()
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menu = menu else {return}
        
        var options: [String] = []
        if !menu[indexPath.row].attributes.isEmpty {
            options = menu[indexPath.row].attributes[0].options
            
        }
        
        let description =  menu[indexPath.row].description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        menuDetail = MenuDetail(id: menu[indexPath.row].id, name: menu[indexPath.row].name, description: description, imageLink: menu[indexPath.row].images[0].src, price: menu[indexPath.row].price, options: options)
        
        performSegue(withIdentifier: "menuDetailSegue", sender: nil)
    }
  
}





extension MenuViewController: MenuInputDelegate{
    
    func setupBage(value: String) {
        if value != "0"{
            tabBarController?.tabBar.items?[2].badgeValue = value+"₽"
        } else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
    }
    
    
    
    func setupCategories(categories: [Categories]) {
        self.categories = categories
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
    }
    
    
    
    func setupMenu(menu: [Menu]) {
        self.menu = menu
        DispatchQueue.main.async {
            self.menuTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}





