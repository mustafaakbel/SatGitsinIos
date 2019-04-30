//
//  Kayit.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 20.03.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
class Kayit: UIViewController {

    
    @IBOutlet weak var txtMailKayit: UITextField!
    @IBOutlet weak var txtPasswordKayit: UITextField!
    @IBOutlet weak var txtIsimKayit: UITextField!
    @IBOutlet weak var lblText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mailFoto = UIImage(named:"mail")
        textFotoKoyma(txtField: txtMailKayit, img: mailFoto!)
        let passwordFoto = UIImage(named:"password")
        textFotoKoyma(txtField: txtPasswordKayit, img: passwordFoto!)
        let personFoto = UIImage(named:"person")
        textFotoKoyma(txtField: txtIsimKayit, img: personFoto!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func s(_ sender: UIButton) {
        lblText.text = "Mustafa"
    }
    
    func textFotoKoyma(txtField: UITextField, img: UIImage){
        let solFotoGoruntu = UIImageView(frame: CGRect(x: 0.0, y: 0, width: 26, height: 26))
        solFotoGoruntu.image = img
        txtField.leftView = solFotoGoruntu
        txtField.leftViewMode = UITextFieldViewMode.always
        txtField.layer.cornerRadius = 20
        txtField.layer.borderWidth = 1.0
        txtField.layer.borderColor = UIColor.darkGray.cgColor
    }

}
