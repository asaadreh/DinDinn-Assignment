//
//  ViewController.swift
//  TestingCustomCollectionView
//
//  Created by Agha Saad Rehman on 06/10/2020.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    
    // IBOutlets declarations
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var goToCartButton : UIButton!
    @IBOutlet var cartIndicator : UILabel!
    
    
    // Model Variables
    var newModels = [[Order]]()
    var orders = [Order]()
    var foodCategories = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()

        populateOrders()
        
        // configuring collection View
        
        collectionView.register(TableCollectionViewCell.nib(), forCellWithReuseIdentifier: TableCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        
        // Assigning gestures
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        let touchGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.pullUpView))
        self.navigationController?.navigationBar.addGestureRecognizer(touchGesture)
        self.navigationController?.navigationBar.addGestureRecognizer(gesture)
    }
    
    func setUp() {
        view.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
        navigationController?.navigationBar.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
    
        // assigning close button to drop VC
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.dropView))
        
        // Aesthetics
        
        goToCartButton.makeRound()
        cartIndicator.makeRound()
        cartIndicator.isHidden = true
        UIView.animate(withDuration: 0.25, animations: {
            
            self.cartIndicator.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // Adding Dummy Data
    
    func populateOrders() {
        
        
        foodCategories.append("Pizza")
        foodCategories.append("Burgers")
        foodCategories.append("Chinese")
        
        var pizzas = [Order]()
        pizzas.append(Order(text: "Fajita", imageName: "pizza_1", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        pizzas.append(Order(text: "Four Cheese", imageName: "pizza_2", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        pizzas.append(Order(text: "Pepparoni", imageName: "pizza_3", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        
        var burgers = [Order]()
        burgers.append(Order(text: "Chicken", imageName: "burger_1", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        burgers.append(Order(text: "Beef", imageName: "burger_2", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        burgers.append(Order(text: "Ground Beef", imageName: "burger_3", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        
        var chinese = [Order]()
        chinese.append(Order(text: "Chowmien", imageName: "chinese_1", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        chinese.append(Order(text: "Beef Chilli Dry", imageName: "chinese_2", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        chinese.append(Order(text: "Sushi", imageName: "chinese_3", detail: "Sample Detail", moreDetail: "Sample More Detail", price: "$41"))
        
        newModels.append(pizzas)
        newModels.append(burgers)
        newModels.append(chinese)
    }
    
    @objc func dropView() {
        print("Touch")
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height*0.75
            self?.navigationController?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    @objc func pullUpView(recognizer: UIPanGestureRecognizer) {
        
        
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            //let yComponent = UIScreen.main.bounds.height
            self?.navigationController?.view.frame = CGRect(x: 0, y: 0, width: frame!.width, height: frame!.height)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height*0.75
            self?.navigationController?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        
        
        
        if let direction = recognizer.direction {
            if direction.isVertical {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    let frame = self?.view.frame
                    //let yComponent = UIScreen.main.bounds.height
                    self?.navigationController?.view.frame = CGRect(x: 0, y: 0, width: frame!.width, height: frame!.height)
                }
            }
        }
    }
    
    @IBAction func goToCartButtonTapped() {
        
        //print("Button Tapped")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.orders = orders
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCollectionViewCell.identifier, for: indexPath) as! TableCollectionViewCell
        cell.orderSelectionDelegate = self
        cell.configure(with: newModels[indexPath.row], for: foodCategories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }
    
}


extension ViewController: OrderSelectionDelegate {
    func didGiveOrder(order: Order) {
        
        self.orders.append(order)
        self.cartIndicator.text = "\(orders.count)"
        if orders.count == 1 {
            cartIndicator.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                
                self.cartIndicator.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.2) {
                self.cartIndicator.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.view.layoutIfNeeded()
            } completion: { (complete) in
                UIView.animate(withDuration: 0.2) {
                    self.cartIndicator.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}

