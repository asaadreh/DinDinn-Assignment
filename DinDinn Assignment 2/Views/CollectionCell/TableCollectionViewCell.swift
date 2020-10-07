//
//  TableCollectionViewCell.swift
//  TestingCustomCollectionView
//
//  Created by Agha Saad Rehman on 06/10/2020.
//

import UIKit



class TableCollectionViewCell: UICollectionViewCell, UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        
        cell.orderSelectionDelegate = self
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    func configure(with models: [Order], for foodCategory: String) {
        self.models = models
        self.foodCategory = foodCategory
        tableView.tableHeaderView = createTableHeader()
        
    }
    static let identifier = "TableCollectionViewCell"
    
    @IBOutlet var tableView : UITableView!
    var orderSelectionDelegate : OrderSelectionDelegate!
    
    
    var models = [Order]()
    var foodCategory = String()
    
    static func nib() -> UINib {
        return UINib(nibName: "TableCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.tableHeaderView = createTableHeader()
        // Initialization code
    }
    
    func createTableHeader() -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: tableView.frame.width,
                                              height: 50))
        headerView.backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 30,
                                          y: headerView.frame.height/3,
                                          width: headerView.frame.width,
                                          height: headerView.frame.height))
        label.text = foodCategory
        print("Food Category at Header Func \(foodCategory)")
        label.font = UIFont.boldSystemFont(ofSize: 40)
        headerView.addSubview(label)
        
        return headerView
    }
}


extension TableCollectionViewCell: OrderSelectionDelegate {
    func didGiveOrder(order: Order) {
        orderSelectionDelegate.didGiveOrder(order: order)
    }
    
    
}
