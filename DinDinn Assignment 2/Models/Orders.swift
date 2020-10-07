//
//  Orders.swift
//  TestingCustomCollectionView
//
//  Created by Agha Saad Rehman on 07/10/2020.
//

import Foundation


struct Order {
    let text : String
    let imageName : String
    var detail : String
    let moreDetail : String
    let price: String
    
    init(text: String, imageName: String, detail:String, moreDetail: String, price: String) {
        self.text = text
        self.imageName = imageName
        self.detail = detail
        self.moreDetail = moreDetail
        self.price = price
    }
    
    mutating func addNumber(num: String){
        detail = detail + num
    }
}
