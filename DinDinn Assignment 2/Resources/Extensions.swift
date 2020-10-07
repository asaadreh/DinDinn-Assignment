//
//  Extensions.swift
//  TestingCustomCollectionView
//
//  Created by Agha Saad Rehman on 06/10/2020.
//

import Foundation
import UIKit

extension UIView {

    func makeRounded() {

        self.layer.borderWidth = 2
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    func makeRound() {

        self.layer.borderWidth = 2
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
}

public enum PanDirection: Int {
    case up, down, left, right
    public var isVertical: Bool { return [.up, .down].contains(self) }
    public var isHorizontal: Bool { return !isVertical }
}

public extension UIPanGestureRecognizer {

   var direction: PanDirection? {
        let velocity = self.velocity(in: view)
        let isVertical = abs(velocity.y) > abs(velocity.x)
        switch (isVertical, velocity.x, velocity.y) {
        case (true, _, let y) where y < 0: return .up
        case (true, _, let y) where y > 0: return .down
        case (false, let x, _) where x > 0: return .right
        case (false, let x, _) where x < 0: return .left
        default: return nil
        }
    }

}
