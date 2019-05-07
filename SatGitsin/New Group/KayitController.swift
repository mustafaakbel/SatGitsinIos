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
    
    
    @IBOutlet weak var KayitOlButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtMailKayit: UITextField!
    @IBOutlet weak var txtPasswordKayit: UITextField!
    @IBOutlet weak var txtIsimKayit: UITextField!
    var kullaniciRef : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kullaniciRef = Database.database().reference().child("Kullanicilar")
        
        let mailFoto = UIImage(named:"mail")
        textFotoKoyma(txtField: txtMailKayit, img: mailFoto!)
        let passwordFoto = UIImage(named:"password")
        textFotoKoyma(txtField: txtPasswordKayit, img: passwordFoto!)
        let personFoto = UIImage(named:"person")
        textFotoKoyma(txtField: txtIsimKayit, img: personFoto!)
        
        ovalYap(nesne: txtMailKayit)
        ovalYap(nesne: txtPasswordKayit)
        ovalYap(nesne: txtIsimKayit)
        ovalYap(nesne: KayitOlButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func KayitOlButton(_ sender: Any) {
        indicator.startAnimating()
        Auth.auth().createUser(withEmail: txtMailKayit.text!, password: txtPasswordKayit.text!) { (kullanici, error) in
            if(error == nil && kullanici != nil){
                Auth.auth().signIn(withEmail:self.txtMailKayit.text!, password: self.txtPasswordKayit.text!, completion: { (user, error) in
                    if(error == nil && kullanici != nil){
                        self.kullaniciEkleme()
                        self.indicator.stopAnimating()
                        let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = tabbar
                        //self.present(anasayfa,animated: true,completion: nil)//Normal Geçiş
                    }else{
                        self.indicator.stopAnimating()
                        self.alertOlustur(title: "Üye Giriş Hatası", mesaj: "Üye girişinde bir sıkıntı oluştu lütfen giriş kısmından tekrar deneyiniz.")
                        print("uye girişi hata")
                    }
                })
                
                
            }else{
                self.indicator.stopAnimating()
                self.alertOlustur(title: "Üye Kayıt Hatası", mesaj: "Üye kayıt oluşturulurken bir sıkıntı oluştu lütfen tekrar deneyiniz.")
                print("Hata")
            }
        }
    }
    func kullaniciEkleme(){
        let userUid = Auth.auth().currentUser!.uid
        let kullanici = [ "uid":userUid,
                          "mail":txtMailKayit.text! as String,
                          "isim":txtIsimKayit.text! as String,
                          "profil_fotograf":"Yok" as String,
                        ]
        kullaniciRef.child(userUid).setValue(kullanici)
    }
    
    func textFotoKoyma(txtField: UITextField, img: UIImage){
        let solFotoGoruntu = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        solFotoGoruntu.image = img
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        view.addSubview(solFotoGoruntu)
        txtField.leftView = view
        txtField.leftViewMode = UITextFieldViewMode.always
    }
    func ovalYap(nesne : AnyObject){
        nesne.layer.cornerRadius = 20
        nesne.layer.borderWidth = 1.0
        nesne.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
    func alertOlustur(title:String,mesaj:String){
        let alert = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
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
