//
//  GirisController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 30.04.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase

class GirisController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtMailGiris: UITextField!
    @IBOutlet weak var txtPasswordGiris: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let mailFoto = UIImage(named:"mail")
        textFotoKoyma(txtField: txtMailGiris, img: mailFoto!)
        let passwordFoto = UIImage(named:"password")
        textFotoKoyma(txtField: txtPasswordGiris, img: passwordFoto!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func GirisButton(_ sender: Any) {
        indicator.startAnimating()
        Auth.auth().signIn(withEmail: txtMailGiris.text!, password:  txtPasswordGiris.text!) { (user, error) in
                if(user != nil && error == nil){
                self.indicator.stopAnimating()
                let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabbar
                //Animasyonlu geçiş
                //self.navigationController?.pushViewController(anasayfa2, animated: true)
            }else {
                self.indicator.stopAnimating()
                self.alertOlustur(title: "Giriş Hatası", mesaj: "Giriş yapılırken bir sıkıntı oluştu lütfen tekrar deneyiniz.")
            }
        }
        
        
    }
    func alertOlustur(title:String,mesaj:String){
        let alert = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

