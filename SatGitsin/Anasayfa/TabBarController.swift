//
//  TabBarController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 1.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = UIColor.black
        self.tabBar.selectedImageTintColor = UIColor(red: 255/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1.0)
    }
    
}
