//
//  IlanVerController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 1.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import ImagePicker

class IlanVerController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ImagePickerDelegate{
    
    
    @IBOutlet weak var UrunCollectionView: UICollectionView!
    @IBOutlet weak var IlanVerButton: UIButton!
    @IBOutlet weak var IlanVerResimSecButton: UIButton!
    @IBOutlet weak var IlanVerUrunOzellik: UITextField!
    @IBOutlet weak var IlanVerUrunFiyat: UITextField!
    @IBOutlet weak var IlanVerUrunBaslik: UITextField!
    @IBOutlet weak var IlanVerPickerView: UIPickerView!
    let IlanlarRef = Database.database().reference().child("Ilanlar")
    let KullaniciRef = Database.database().reference().child("Kullanicilar")
    var secili_kategori:String = ""
    let imagePicker = ImagePickerController()
    let ilanStorageRef = Storage.storage().reference().child("Ilanlar")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ovalYap(nesne: IlanVerUrunBaslik)
        ovalYap(nesne: IlanVerUrunOzellik)
        ovalYap(nesne: IlanVerUrunFiyat)
        ovalYap(nesne: IlanVerButton)
        ovalYap(nesne: IlanVerResimSecButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func FotografEkleme(_ sender: Any) {
        
        imagePicker.imageLimit = 3
        imagePicker.delegate = self as ImagePickerDelegate
        present(imagePicker, animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        UrunCollectionView.isHidden = false
        dismiss(animated: true, completion: nil)
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        UrunCollectionView.isHidden = false
        UrunCollectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
        UrunCollectionView.isHidden = false
        UrunCollectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    public var imageAssets: [UIImage] {
        return AssetManager.resolveAssets(imagePicker.stack.assets)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UrunFotoCollectionViewCell", for: indexPath) as! UrunFotoCollectionViewCell
        cell.urunFoto.image = imageAssets[indexPath.row]
        return cell
    }
    
    let kategori = ["ARABA", "EMLAK", "ELEKTRONİK", "EV VE BAHÇE", "SPOR, EĞLENCE VE OYUNLAR","GİYİM VE AKSESUAR", "BEBEK VE COCUK", "FİLM, KİTAP VE MÜZİK","DİĞER"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        secili_kategori = kategori[row] as String
        return kategori[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kategori.count
    }

    @IBAction func IlanverButon(_ sender: Any) {
        IlanKaydet()
    }
    func IlanKaydet(){
        if UrunCollectionView.isHidden == false {
            let baslik = IlanVerUrunBaslik.text
            let ozellik = IlanVerUrunOzellik.text
            let fiyat = IlanVerUrunFiyat.text
            let uId = Auth.auth().currentUser?.uid
            if((baslik?.isEmpty)! || (ozellik?.isEmpty)! || (fiyat?.isEmpty)!){
                alertOlustur(title: "Zorunlu", mesaj: "Ürünün değerlerini giriniz..")
            }else{
                let key = IlanlarRef.childByAutoId().key
                /*let ilan = Ilan()
                 ilan.uid = uId
                 ilan.baslik = baslik
                 ilan.ozellik = ozellik
                 ilan.fiyat = fiyat
                 ilan.ilk_urun_foto = "Yok"
                 ilan.kategori=secili_kategori
                 ilan.urun_foto_adet = String(imageAssets.count)*/
                
                let ilan = [      "ilanId":key,
                                   "uid":uId,
                                  "baslik":baslik,
                                  "ozellik":ozellik,
                                  "fiyat":fiyat,
                                  "satilma_durumu":"0",
                                  "kategori":secili_kategori,
                                  "ilk_urun_foto" : "Yok",
                                  "urun_foto_adet" : String(imageAssets.count)
                ]
                IlanlarRef.child(key!).setValue(ilan)
                fotoYukleme(key: key!)
                UrunCollectionView.isHidden = true
                IlanVerUrunBaslik.text = ""
                IlanVerUrunOzellik.text = ""
                IlanVerUrunFiyat.text = ""
            }
        }else{
            alertOlustur(title: "Resim Seç Hatası", mesaj: "Ürünün en az bir fotoğrafı yüklenmelidir..")
        }
        

    }
    
    func fotoYukleme(key : String){
        if(imageAssets.count != 0){
            for i in 0 ..< imageAssets.count {
                let konum = ilanStorageRef.child(key).child(String(i)+".jpg")
                let imageData = UIImageJPEGRepresentation(imageAssets[i], 1)
                let uploadTask = konum.putData(imageData!, metadata: nil) { (metadata, error) in
                    print(metadata ?? "META YOK")
                    print(error ?? "Hata Yok")
                    konum.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            return
                        }
                        let downloadURL = url?.absoluteString
                        if(i == 0){
                            self.IlanlarRef.child(key).child("ilk_urun_foto").setValue(downloadURL)
                        }
                    })
                }
                uploadTask.observe(.progress) { (snapshot) in
                    print(snapshot.progress ?? "Progres yok")
                }
                uploadTask.resume()
            }
        }else{
             alertOlustur(title: "Resim Seç Hatası", mesaj: "Ürünün en az bir fotoğrafı yüklenmelidir..")
        }
        
    }
    
    func alertOlustur(title:String,mesaj:String){
        let alert = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }
    func ovalYap(nesne : AnyObject){
        nesne.layer.cornerRadius = 20
        nesne.layer.borderWidth = 1.0
        nesne.layer.borderColor = UIColor.darkGray.cgColor
    }


}
