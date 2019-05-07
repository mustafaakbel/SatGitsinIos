//
//  IlanDetayController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 6.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class IlanDetayController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var DuzenleButton: UIBarButtonItem!
    @IBOutlet weak var ilanBaslik: UILabel!
    @IBOutlet weak var ilanFiyat: UILabel!
    @IBOutlet weak var ilanAciklama: UILabel!
    @IBOutlet weak var ilanFotoCollection: UICollectionView!
    @IBOutlet weak var ilanDetayButton: UIButton!
    var storageRef = Storage.storage().reference().child("Ilanlar")
    var ilanListe = [Ilan]()
    var imageUrl = [String]()
    var ilanIdSegue : String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        ovalYap(nesne: ilanDetayButton)
        IlanGetir(yeniden: "İlk")
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        imageUrl.removeAll()
        IlanGetir(yeniden: "Tekrar")
    }
    
    func Kontrol(){
        
    }
    func IlanGetir(yeniden:String){
        let dbRef = Database.database().reference().child("Ilanlar").child(ilanIdSegue!)
        dbRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let ilanNesne = snapshot.value as? NSDictionary
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
            self.ilanAciklama.text = ilan.ozellik!
            self.ilanBaslik.text = ilan.baslik
            self.ilanFiyat.text = ilan.fiyat
            self.ilanListe.append(ilan)
            if(yeniden == "İlk"){
                let a = Int(ilan.urun_foto_adet!)!+0
                for i in 0 ..< a {
                    self.storageRef.child(ilan.ilanId! ).child(String(i)+".jpg").downloadURL { (url, error) in
                        if url != nil && error == nil {
                            let UrlString = url?.absoluteString
                            self.imageUrl.append(UrlString!)
                            self.ilanFotoCollection.reloadData()
                        }
                    }
                }
            }

            
            print(ilanOzellik)
        }) { (error) in
            print(error.localizedDescription)
        }
        
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UrunDetayCollectionViewCell", for: indexPath) as! UrunDetayCollectionViewCell
        print(imageUrl[indexPath.row])
        let url = URL(string: imageUrl[indexPath.row])
        let data = try? Data(contentsOf: url!)
        cell.ilanFoto.image = UIImage(data: data!)
        //cell.ilanFoto.image = image[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrl.count
    }
    
    @IBAction func Duzenle(_ sender: Any) {
        self.performSegue(withIdentifier: "ilanDetay", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? IlanGuncelleController
        let ilanBaslik2 = ilanListe[0].baslik!
        let ilanFiyat2 = ilanListe[0].fiyat!
        let ilanOzellik2 = ilanListe[0].ozellik!
        let ilanId2 = ilanListe[0].ilanId!
        destination?.SegueilanBaslik = ilanBaslik2
        destination?.SegueilanFiyat = ilanFiyat2
        destination?.SegueilanOzellik = ilanOzellik2
        destination?.SegueilanId = ilanId2
        //if let ilanIdSegue = IlanListe[selectedRow!].ilanId{
          //  destination?.ilanIdSegue = ilanIdSegue
        //}
    }
    
    func ovalYap(nesne : AnyObject){
        nesne.layer.cornerRadius = 20
        nesne.layer.borderWidth = 1.0
        nesne.layer.borderColor = UIColor.darkGray.cgColor
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
