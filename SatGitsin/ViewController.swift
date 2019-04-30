//
//  ViewController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 18.03.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var kayit: UIView!
    @IBOutlet weak var giris: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func KayitGirisSegmentKontrol(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            kayit.alpha = 1
            giris.alpha = 0
            self.navigationItem.title = "Yeni hesap oluştur"
            break
        case 1:
            kayit.alpha = 0
            giris.alpha = 1
            self.navigationItem.title = "E-posta ile giriş yap"
            break
        default:
            break
        }
    }

}

