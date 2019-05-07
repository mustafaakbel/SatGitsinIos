//
//  AnasayfaController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 1.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
class AnasayfaController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate {

    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var dbRef = Database.database().reference().child("Ilanlar")
    var IlanListe = [Ilan]()
    
    @IBOutlet weak var ilanTableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageDizi = [UIImage(named:"kategori_araba_icon_round"),UIImage(named:"kategori_emlak_icon_round"),UIImage(named:"kategori_elektronik_icon_round"),UIImage(named:"kategori_evbahce_icon_round"),
                    UIImage(named:"kategori_spor_icon_round"),UIImage(named:"kategori_giyim_icon_round"),UIImage(named:"kategori_bebekcocuk_icon_round"),UIImage(named:"kategori_filmkitap_icon_round"),
                    UIImage(named:"kategori_diger_icon_round")]
    var kategoriAd = ["ARABA", "EMLAK", "ELEKTRONİK", "EV VE BAHÇE", "SPOR, EĞLENCE VE OYUNLAR","GİYİM VE AKSESUAR", "BEBEK VE COCUK", "FİLM, KİTAP VE MÜZİK","DİĞER"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ilanlarGetir()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func ilanlarGetir(){
        
        dbRef.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount  > 0 {
                    self.IlanListe.removeAll()
                
                    for ilanlar in snapshot.children.allObjects as![DataSnapshot]{
                        let ilanNesne = ilanlar.value as? [String : AnyObject]
                        let  ilanId = ilanNesne?["ilanId"]
                        let  ilanBaslik = ilanNesne?["baslik"]
                        let  ilanOzellik = ilanNesne?["ozellik"]
                        let  ilanUrunFotoAdet = ilanNesne?["urun_foto_adet"]
                        let  ilanIlkFoto = ilanNesne?["ilk_urun_foto"]
                        let  ilanFiyat = ilanNesne?["fiyat"]
                        let  ilanUid = ilanNesne?["uid"]
                        let  ilanSatilmaDurumu = ilanNesne?["satilma_durumu"]
                        let  ilanKategori = ilanNesne?["kategori"]
                        
                        let ilan = Ilan(ilanId: ilanId as! String?,uid: ilanUid as! String?,baslik: ilanBaslik as! String?,ozellik: ilanOzellik as! String?,fiyat: ilanFiyat as! String?,satilma_durumu: ilanSatilmaDurumu as! String?,kategori: ilanKategori as! String?,ilk_urun_foto: ilanIlkFoto as! String?,urun_foto_adet: ilanUrunFotoAdet as! String?)
                        self.IlanListe.append(ilan)
                    }
                self.ilanTableView.reloadData()
                }
            
            })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IlanListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IlanTableViewCell", for: indexPath) as! IlanTableViewCell
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ilanDetay", sender: indexPath.row)
        print(IlanListe[indexPath.row].baslik!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedRow = sender as? Int
         let destination = segue.destination as? IlanDetayController
        if let ilanIdSegue = IlanListe[selectedRow!].ilanId{
            destination?.ilanIdSegue = ilanIdSegue
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDizi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KategoriCollectionViewCell", for: indexPath) as! KategoriCollectionViewCell
        cell.imgImage.image = imageDizi[indexPath.row]
        cell.KategoriLabel.text = kategoriAd[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let secilicell = collectionView.cellForItem(at: indexPath)as? KategoriCollectionViewCell
        secilicell?.KategoriLabel.textColor = UIColor.lightGray
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indicator.startAnimating()
        let secilicell = collectionView.cellForItem(at: indexPath)as? KategoriCollectionViewCell
        secilicell?.KategoriLabel.textColor = UIColor.blue
        dbRef.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount  > 0 {
                self.IlanListe.removeAll()
                
                for ilanlar in snapshot.children.allObjects as![DataSnapshot]{
                    let ilanNesne = ilanlar.value as? [String : AnyObject]
                    let  ilanId = ilanNesne?["ilanId"]
                    let  ilanBaslik = ilanNesne?["baslik"]
                    let  ilanOzellik = ilanNesne?["ozellik"]
                    let  ilanUrunFotoAdet = ilanNesne?["urun_foto_adet"]
                    let  ilanIlkFoto = ilanNesne?["ilk_urun_foto"]
                    let  ilanFiyat = ilanNesne?["fiyat"]
                    let  ilanUid = ilanNesne?["uid"]
                    let  ilanSatilmaDurumu = ilanNesne?["satilma_durumu"]
                    let  ilanKategori = ilanNesne?["kategori"]
                    
                    let ilan = Ilan(ilanId: ilanId as! String?,uid: ilanUid as! String?,baslik: ilanBaslik as! String?,ozellik: ilanOzellik as! String?,fiyat: ilanFiyat as! String?,satilma_durumu: ilanSatilmaDurumu as! String?,kategori: ilanKategori as! String?,ilk_urun_foto: ilanIlkFoto as! String?,urun_foto_adet: ilanUrunFotoAdet as! String?)
                    if(ilan.kategori == self.kategoriAd[indexPath.row]){
                        self.IlanListe.append(ilan)
                    }
                    
                }
                
                self.ilanTableView.reloadData()
                self.indicator.stopAnimating()            }
            
        })
    }
    



}
