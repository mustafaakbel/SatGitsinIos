//
//  UILabel.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 10.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit

extension UILabel {
    var YukseklikAyarla : CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width,
                                              height:CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
    }
}
