//
//  MyTableViewCell.swift
//  TestingCustomCollectionView
//
//  Created by Agha Saad Rehman on 06/10/2020.
//

import UIKit
import RxSwift
import RxCocoa

protocol OrderSelectionDelegate {
    func didGiveOrder(order: Order)
}

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet var myLabel : UILabel!
    @IBOutlet var myImageView : UIImageView!
    @IBOutlet var detailLabel : UILabel!
    @IBOutlet var moreDetailLabel : UILabel!
    @IBOutlet var addToCartButton : UIButton!
    
    var model : Order!
    
    var orderSelectionDelegate : OrderSelectionDelegate!
    
    private var ordersVariable = BehaviorRelay(value: Order(text: "dummyText",
                                                                         imageName: "dummyText",
                                                                         detail: "dummyText",
                                                                         moreDetail: "dummyText",
                                                                         price: "dummyText"))
    
    var orders : Observable<Order> {
        return ordersVariable.asObservable()
    }
    
    static let identifier = "MyTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func configure(with model : Order) {
        
        self.model = model
        self.myLabel.text = model.text
        self.myImageView?.image = UIImage(named: model.imageName)
        self.myImageView.contentMode = .scaleAspectFill
        self.detailLabel.text = model.detail
        self.moreDetailLabel.text = model.moreDetail
        self.addToCartButton.setTitle(model.price, for: .normal)
        self.addToCartButton.setTitleColor(.white, for: .normal)
        //self.addToCartButton.setBackgroundImage(UIImage(named: "GreenBackground"), for: .highlighted)
        //self.addToCartButton.setTitle("Added!", for: .highlighted)
        self.addToCartButton.backgroundColor = .black
        self.addToCartButton.makeRounded()
        self.myImageView.makeRounded()
        //self.imageView?.contentMode = .scaleAspectFill
        
        
        //self.imageView?.isHidden = true
    }
    
    @IBAction func addToCartButtonTapped() {
        print("Button Tapped")
        
        //ordersVariable.accept(model)
        
        orderSelectionDelegate.didGiveOrder(order: model)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.addToCartButton.backgroundColor = .link
            self.addToCartButton.setTitle("Added", for: .normal)
            
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            UIView.animate(withDuration: 0.5) {
                self.addToCartButton.setTitle("\(self.model.price)", for: .normal)
                self.addToCartButton.backgroundColor = .black
            }
            
        }
        
    }
    
}
