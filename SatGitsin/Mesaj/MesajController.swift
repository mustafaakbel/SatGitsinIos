//
//  MesajController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 1.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
class MesajController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dbRef = Database.database().reference()
    var mesajDizi = [Mesaj]()
    var kullanicilar = [Kullanici]()
    var mesajlarDict = [String: Mesaj]()
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mesajlarGetir()
        self.tabBarController?.tabBar.isHidden = false
        mesajDizi.removeAll()
        mesajlarDict.removeAll()
        mTableView.reloadData()
        kullaniciMesajlari()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        mesajDizi.removeAll()
        mesajlarDict.removeAll()
        mTableView.reloadData()
        kullaniciMesajlari()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesajDizi.count
    }
    
    func kullaniciMesajlari(){
        dbRef.child("kullanici-mesajlar").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: { (snapshot) in
            let mesajId = snapshot.key
            let MesajRef = Database.database().reference().child("Mesajlar").child(mesajId)
            MesajRef.observe(.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject] {
                    let mesaj = Mesaj()
                    mesaj.setValuesForKeys(dict)
                    if let aliciid = mesaj.AliciId() {
                        self.mesajlarDict[aliciid] = mesaj
                        self.mesajDizi = Array(self.mesajlarDict.values)
                    }
                    
                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.elleYenileme), userInfo: nil, repeats: false)
                    
                }
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    var timer: Timer?
    
    @objc func elleYenileme() {
        print("Olduuuu")
        self.mTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mesaj = mesajDizi[indexPath.row]
        guard let aId = mesaj.AliciId() else {
            return
        }
        let ref = Database.database().reference().child("Kullanicilar").child(aId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let kullaniciNesne = snapshot.value as? NSDictionary
            let kullanici = Kullanici()
            kullanici.uid = kullaniciNesne?["uid"] as! String
            self.performSegue(withIdentifier: "MesajlasmaSegue", sender: kullanici.uid)
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? MesajlasmaSayfasiController
        let KulId = sender
        destination?.uid = KulId as! String
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MesajlasmaCell", for: indexPath) as! MesajlasmaCell
        cell.mesajIcerik.text = mesajDizi[indexPath.row].mesaj
        let alici:String?
        if(mesajDizi[indexPath.row].gonderenId == Auth.auth().currentUser?.uid) {
            alici = mesajDizi[indexPath.row].aliciId
        }else {
            alici = mesajDizi[indexPath.row].gonderenId
        }

        cell.mesajFoto.layer.borderWidth = 1
        cell.mesajFoto.layer.masksToBounds = false
        cell.mesajFoto.layer.borderColor = UIColor.black.cgColor
        cell.mesajFoto.layer.cornerRadius = cell.mesajFoto.frame.height/2
        cell.mesajFoto.clipsToBounds = true
        let konum = dbRef.child("Kullanicilar").child(alici!)
        konum.observeSingleEvent(of: .value, with: { (snapshot) in
            let kullaniciNesne = snapshot.value as? NSDictionary
            let k = Kullanici()
            k.profil_fotograf = String(describing: kullaniciNesne?["profil_fotograf"])
            let image = kullaniciNesne?["profil_fotograf"]
            let isim = kullaniciNesne?["isim"]
            cell.mesajIsim.text = isim as! String
            if (k.profil_fotograf != "Yok"){
                let url = URL(string: image as! String)
                let data = try? Data(contentsOf: url!)
                cell.mesajFoto.image = UIImage(data: data!)
            }
           
        }) { (error) in
            print(error.localizedDescription)
        }
        if let saniye = mesajDizi[indexPath.row].zaman?.doubleValue{
            let zamanTarih = Date(timeIntervalSince1970: saniye)
            let tarihFormat = DateFormatter()
            tarihFormat.dateFormat = "hh:mm:ss a"
            cell.mesajTarih.text = tarihFormat.string(from: zamanTarih)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
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
