//
//  SatiliyorViewController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 7.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
class SatiliyorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var pTableView: UITableView!
    var IlanListe = [Ilan]()
    var dbRef = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        ilanlarGetir()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IlanListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilIlanTableViewCell", for: indexPath) as! IlanTableViewCell
        let ilan: Ilan
        ilan = IlanListe[indexPath.row]
        cell.IlanBaslik.text = ilan.baslik
        cell.IlanFiyat.text = ilan.fiyat
        cell.IlanImageView.layer.borderWidth = 1
        cell.IlanImageView.layer.masksToBounds = false
        cell.IlanImageView.layer.borderColor = UIColor.black.cgColor
        cell.IlanImageView.layer.cornerRadius = cell.IlanImageView.frame.height/2
        cell.IlanImageView.clipsToBounds = true
        if  (ilan.ilk_urun_foto != "Yok"){
            let url = URL(string: ilan.ilk_urun_foto!)
            let data = try? Data(contentsOf: url!)
            cell.IlanImageView.image = UIImage(data: data!)
        }
        print(ilan.baslik! ?? "boş")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func ilanlarGetir(){
        
        dbRef.child("Ilanlar").observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount  > 0 {
                self.IlanListe.removeAll()
                
                for ilanlar in snapshot.children.allObjects as![DataSnapshot]{
                    let ilanNesne = ilanlar.value as? [String : AnyObject]
                    let  ilanSatilmaDurumu = ilanNesne?["satilma_durumu"]
                    let  ilanId = ilanNesne?["ilanId"]
                    let  ilanBaslik = ilanNesne?["baslik"]
                    let  ilanOzellik = ilanNesne?["ozellik"]
                    let  ilanUrunFotoAdet = ilanNesne?["urun_foto_adet"]
                    let  ilanIlkFoto = ilanNesne?["ilk_urun_foto"]
                    let  ilanFiyat = ilanNesne?["fiyat"]
                    let  ilanUid = ilanNesne?["uid"]
                    
                    let  ilanKategori = ilanNesne?["kategori"]
                    
                    let ilan = Ilan(ilanId: ilanId as! String?,uid: ilanUid as! String?,baslik: ilanBaslik as! String?,ozellik: ilanOzellik as! String?,fiyat: ilanFiyat as! String?,satilma_durumu: ilanSatilmaDurumu as! String?,kategori: ilanKategori as! String?,ilk_urun_foto: ilanIlkFoto as! String?,urun_foto_adet: ilanUrunFotoAdet as! String?)
                    if (ilan.satilma_durumu == "0" && ilan.uid == Auth.auth().currentUser?.uid){
                        self.IlanListe.append(ilan)
                    }
                }
                self.pTableView.reloadData()
            }
            
        })
        
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
