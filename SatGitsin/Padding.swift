//
//  Padding.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 3.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit

class Padding: UITextField {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(15, 25, 15, 15))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(15, 25, 15, 15))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(15, 25, 15, 15))
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
