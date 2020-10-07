//
//  CartTableViewCell.swift
//  TestingCustomCollectionView
//
//  Created by Agha Saad Rehman on 07/10/2020.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    static let identifier = "CartTableViewCell"
    
    @IBOutlet var itemImage : UIImageView!
    @IBOutlet var itemName : UILabel!
    @IBOutlet var itemPrice : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model: Order) {
        self.itemName.text = model.text
        self.itemImage.image = UIImage(named: model.imageName)
        self.itemPrice.text = model.price
        self.itemImage.contentMode = .scaleAspectFill
        self.itemImage.makeRounded()
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "CartTableViewCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
