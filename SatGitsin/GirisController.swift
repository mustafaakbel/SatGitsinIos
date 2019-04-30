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

    @IBOutlet weak var txtMailGiris: UITextField!
    @IBOutlet weak var txtPasswordGiris: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let mailFoto = UIImage(named:"mail")
        textFotoKoyma(txtField: txtMailGiris, img: mailFoto!)
        let passwordFoto = UIImage(named:"password")
        textFotoKoyma(txtField: txtPasswordGiris, img: passwordFoto!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GirisButton(_ sender: Any) {
        
        /*
        Auth.auth().signIn(withEmail: txtMailGiris.text!, password:  txtPasswordGiris.text!) { (user, error) in
            if(user != nil && error == nil){
                let anasayfa2 = self.storyboard?.instantiateViewController(withIdentifier: "Anasayfa") as! Anasayfa
                self.present(anasayfa2,animated: true,completion: nil)//Normal Geçiş
                self.txtPasswordGiris.text = ""
                self.txtMailGiris.text = ""
                //Animasyonlu geçiş
                //self.navigationController?.pushViewController(anasayfa2, animated: true)
            }else {
                print("Yanlışşş")
            }*/
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


