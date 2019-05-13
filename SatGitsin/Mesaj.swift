//
//  Mesaj.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 8.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import  Firebase
class Mesaj: NSObject {
    @objc var aliciId : String?
    @objc var gonderenId : String?
    @objc var mesaj : String?
    @objc var zaman : NSNumber?
    
    func AliciId() -> String? {
        return gonderenId == Auth.auth().currentUser?.uid ? aliciId : gonderenId
    }
}
