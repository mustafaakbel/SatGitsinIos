//
//  ProfilController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 30.04.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class ProfilController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var txtProfilMail: UILabel!
    @IBOutlet weak var txtProfilIsim: UILabel!
    @IBOutlet weak var imageDegistirme: UIButton!
    @IBOutlet weak var profilFotoImageView: UIImageView!
    let kullanici = Auth.auth().currentUser
    var kullaniciRef = Database.database().reference().child("Kullanicilar")
    let storageRef = Storage.storage().reference().child("profil_foto")
    var downloadImageUrl:String?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        kullaniciRef.keepSynced(true)
        yuvarlakImage()
        yuvarlakButton()
        kullaniciAyarlari()
        
        
        //self.kullaniciRef.child((self.kullanici?.uid)!).setValue(["isim": "asd"])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func kullaniciAyarlari(){

        
        let uid = kullanici?.uid
        kullaniciRef.child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let ad = value?["isim"] as? String ?? ""
            let mail = value?["mail"] as? String ?? ""
            let p_foto = value?["profil_fotograf"] as? String ?? "Yok"
            self.txtProfilMail.text = mail
            self.txtProfilIsim.text = ad
            if p_foto == "Yok"{
                self.profilFotoImageView.image=UIImage(named: "person_avatar")
            }else{
                let url = URL(string: p_foto)
                let data = try? Data(contentsOf: url!)
                self.profilFotoImageView.image = UIImage(data: data!)
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func AvatarDegistirme(_ sender: Any) {
        let fotoController = UIImagePickerController()
        fotoController.delegate = self
        fotoController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(fotoController,animated: true,completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let uId = kullanici?.uid
        profilFotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage, 1)
        let konum = storageRef.child(uId!+".jpg")
        let uploadTask = konum.putData(imageData!, metadata: nil) { (metadata, error) in
            print(metadata ?? "META YOK")
            print(error ?? "Hata Yok")
            konum.downloadURL(completion: { (url, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                let downloadURL = url?.absoluteString
                self.kullaniciRef.child((self.kullanici?.uid)!).child("profil_fotograf").setValue(downloadURL)
            })
        }
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "Progres yok")
        }
        uploadTask.resume()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CikisYap(_ sender: Any) {
        //try! Auth.auth().signOut()
        let anasayfa = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = anasayfa
    }
    

    
    func yuvarlakButton(){
        imageDegistirme.layer.cornerRadius = imageDegistirme.frame.height/2
        imageDegistirme.clipsToBounds = true
        imageDegistirme.layer.masksToBounds = false
    }
    
    func yuvarlakImage(){
        profilFotoImageView.layer.borderWidth = 1
        profilFotoImageView.layer.masksToBounds = false
        profilFotoImageView.layer.borderColor = UIColor.black.cgColor
        profilFotoImageView.layer.cornerRadius = profilFotoImageView.frame.height/2
        profilFotoImageView.clipsToBounds = true
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
