//
//  PaddingTextField.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 23.04.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 15, 0, 15))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 15, 0, 15))
    }
}
