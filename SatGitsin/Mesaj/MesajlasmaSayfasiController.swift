//
//  MesajlasmaSayfasiController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 8.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
class MesajlasmaSayfasiController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate{

    var uid : String = ""
    @IBOutlet weak var profilIsim: UIButton!
    @IBOutlet weak var mesajlarCollection: UICollectionView!
    @IBOutlet weak var mesajAlani: UITextField!
    @IBOutlet weak var mesajGonderButton: UIButton!
    var mesajDizi = [Mesaj]()
    var dbRef = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        ovalYap(nesne: mesajAlani)
        self.tabBarController?.tabBar.isHidden = true
        KullaniciBul()
        mesajlarGetir()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mesajlarGetir(){
        let KullaniciMesaj = Database.database().reference().child("kullanici-mesajlar").child((Auth.auth().currentUser?.uid)!)
        KullaniciMesaj.observe(.childAdded, with: { (snapshot) in
            let mesajId = snapshot.key
            let MesajRef = Database.database().reference().child("Mesajlar").child(mesajId)
            MesajRef.observe(.value, with: { (snapshot) in
                guard let dict = snapshot.value as? [String: AnyObject] else {
                    return
                }
                let mesaj = Mesaj()
                mesaj.setValuesForKeys(dict)
                if mesaj.AliciId() == self.uid{
                    self.mesajDizi.append(mesaj)
                    self.mesajlarCollection.reloadData()
                }
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func KullaniciBul(){
        let konum = dbRef.child("Kullanicilar").child(uid)
        konum.observeSingleEvent(of: .value, with: { (snapshot) in
            let kullaniciNesne = snapshot.value as? NSDictionary
            let k = Kullanici()
            k.isim = kullaniciNesne?["isim"] as! String
            self.profilIsim.setTitle(k.isim, for: .normal)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mesajDizi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MesajCell", for: indexPath) as! MesajCell
        if(mesajDizi[indexPath.row].gonderenId == Auth.auth().currentUser?.uid){
            cell.msajIcerik.isHidden = false
            cell.mesajGelen.isHidden = true
            let gelenYukseklik = cell.msajIcerik.YukseklikAyarla
            cell.msajIcerik.frame = CGRect(x: cell.msajIcerik.frame.origin.x, y: cell.msajIcerik.frame.origin.y, width: cell.msajIcerik.frame.width, height: gelenYukseklik)
            cell.msajIcerik.numberOfLines = 0
            cell.msajIcerik.text = mesajDizi[indexPath.row].mesaj
        }else{
            cell.mesajGelen.isHidden = false
            cell.msajIcerik.isHidden = true
            let gelenYukseklik = cell.mesajGelen.YukseklikAyarla
            cell.mesajGelen.frame = CGRect(x: cell.mesajGelen.frame.origin.x, y: cell.mesajGelen.frame.origin.y, width: cell.mesajGelen.frame.width, height: gelenYukseklik)
            cell.mesajGelen.numberOfLines = 0
            cell.mesajGelen.text = mesajDizi[indexPath.row].mesaj
        }
        return cell
    }

    
    @IBAction func profiGit(_ sender: Any) {
        self.performSegue(withIdentifier: "profilDetaySegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? ProfilDetayController
        dest?.Kisiuid = uid
        
    }
    
    @IBAction func MesajGonder(_ sender: Any) {
        let mesajDb = dbRef.child("Mesajlar")
        let konum = mesajDb.childByAutoId()
        let zaman = NSDate().timeIntervalSince1970
        let gonderenid = Auth.auth().currentUser?.uid
        let mesajNese = [
                      "mesaj":mesajAlani.text! as String,
                      "gonderenId":gonderenid as Any,
                      "aliciId":uid,
                      "zaman":zaman,
                      ] as [String : Any]
        //konum.setValue(mesajNese)
        konum.updateChildValues(mesajNese) { (error,ref) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            self.mesajAlani.text = ""
         }
        let kullaniciMesajRef = Database.database().reference().child("kullanici-mesajlar").child(gonderenid!)
        let mesajId = konum.key
        kullaniciMesajRef.updateChildValues([mesajId!: 1])
        
        let digerKullaniciMesajRef = Database.database().reference().child("kullanici-mesajlar").child(uid)
        digerKullaniciMesajRef.updateChildValues([mesajId!: 1])
    }
    
    func ovalYap(nesne : AnyObject){
        nesne.layer.cornerRadius = 20
        nesne.layer.borderWidth = 1.0
        nesne.layer.borderColor = UIColor.darkGray.cgColor
    }
}
