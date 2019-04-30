//
//  KayitController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 30.04.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
class KayitController: UIViewController {

    @IBOutlet weak var txtMailKayit: UITextField!
    @IBOutlet weak var txtPasswordKayit: UITextField!
    @IBOutlet weak var txtIsimKayit: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mailFoto = UIImage(named:"mail")
        textFotoKoyma(txtField: txtMailKayit, img: mailFoto!)
        let passwordFoto = UIImage(named:"password")
        textFotoKoyma(txtField: txtPasswordKayit, img: passwordFoto!)
        let personFoto = UIImage(named:"person")
        textFotoKoyma(txtField: txtIsimKayit, img: personFoto!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    @IBAction func KayitOlButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: txtMailKayit.text!, password: txtPasswordKayit.text!) { (kullanici, error) in
            if(error == nil && kullanici != nil){
                print("oldu")
                Auth.auth().signIn(withEmail:self.txtMailKayit.text!, password: self.txtPasswordKayit.text!, completion: { (user, error) in
                    if(error == nil && kullanici != nil){
                        let anasayfa = self.storyboard?.instantiateViewController(withIdentifier: "Anasayfa") as! Anasayfa
                        self.present(anasayfa,animated: true,completion: nil)//Normal Geçiş
                    }else{
                        print("uye girişi hata")
                    }
                })
                
                
            }else{
                print("Hata")
            }
        }
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
