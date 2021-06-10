//
//  UIView+Extension.swift
//  ToDoey
//
//  Created by Amisha I on 10/06/21.
//

import UIKit

extension UIView {
    
    func setCircular(withBorderWidth: CGFloat = 0, borderColor: UIColor = UIColor.lightGray) {
        self.clipsToBounds = true
        self.layer.cornerRadius = (self.frame.height) / 2
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = withBorderWidth
    }
    
    func setShadow() {
        let bounds: CGRect = self.bounds
        let frame: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width + bounds.height, height: bounds.height)
        let shadowPath = UIBezierPath(roundedRect: frame.offsetBy(dx: 0, dy: 0), cornerRadius: self.layer.cornerRadius)
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowRadius = 11
    }
}

