//
//  CartViewController.swift
//  TestingCustomCollectionView
//
//  Created by Agha Saad Rehman on 06/10/2020.
//

import UIKit

class CartViewController: UIViewController {
    

    @IBOutlet var tableView : UITableView!
    @IBOutlet var checkOutButton : UIButton!
    let tableHeadersForCart = ["Cart", "Info", "Something"]
    
    var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting things up
        
        checkOutButton.makeRound()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartTableViewCell.nib(), forCellReuseIdentifier: CartTableViewCell.identifier)
        tableView.tableHeaderView = createTableHeader()
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
   
    func createTableHeader() -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: tableView.frame.width,
                                              height: 75))
        headerView.backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 10,
                                          y: 20,
                                          width: headerView.frame.width,
                                          height: headerView.frame.height))
        label.text = "Cart"
        
        label.font = UIFont.boldSystemFont(ofSize: 35)
        headerView.addSubview(label)
        
        return headerView
    }

}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier) as! CartTableViewCell
        
        cell.configure(with: orders[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

