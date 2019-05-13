//
//  IlanGuncelleController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 7.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
class IlanGuncelleController: UIViewController {

    @IBOutlet weak var ilanGuncelle: UIButton!
    @IBOutlet weak var ilanBasligi: UITextField!
    @IBOutlet weak var ilanFiyati: UITextField!
    @IBOutlet weak var ilanOzellik: UITextField!
    var SegueilanBaslik : String = ""
    var SegueilanFiyat : String = ""
    var SegueilanOzellik : String = ""
    var SegueilanId : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ovalYap(nesne: ilanOzellik)
        ovalYap(nesne: ilanFiyati)
        ovalYap(nesne: ilanBasligi)
        ovalYap(nesne: ilanGuncelle)
        ilanBasligi.text = SegueilanBaslik
        ilanFiyati.text = SegueilanFiyat
        ilanOzellik.text = SegueilanOzellik
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func ovalYap(nesne : AnyObject){
        nesne.layer.cornerRadius = 20
        nesne.layer.borderWidth = 1.0
        nesne.layer.borderColor = UIColor.darkGray.cgColor
    }
    @IBAction func Guncelle(_ sender: Any) {
        let dbRef = Database.database().reference().child("Ilanlar").child(SegueilanId)
        dbRef.child("baslik").setValue(ilanBasligi.text!)
        dbRef.child("fiyat").setValue(ilanFiyati.text!)
        dbRef.child("ozellik").setValue(ilanOzellik.text!)
        alertOlustur(title: "İlan Güncelle", mesaj: "İlanınız Güncellenmiştir.")
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
