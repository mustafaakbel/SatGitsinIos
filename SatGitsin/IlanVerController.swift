//
//  IlanVerController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 1.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit

class IlanVerController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Resim seçme
    @IBOutlet weak var ilanVerUrunImage: UIImageView!
    @IBAction func FotografEkleme(_ sender: Any) {
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            ilanVerUrunImage.image=image
        }
        else
        {
            //error mesage
        }
        self.dismiss(animated: true, completion: nil)
    }
   
    // ilan kategori seçme
    @IBOutlet weak var IlanVerKategoriTxt: UILabel!
    @IBOutlet weak var IlanVerPickerView: UIPickerView!
    let foods = ["apples", "Banana", "Cora", "dfadgdsg", "fdasfs","fsdfgd", "fdgdh", "afdfdsgd"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foods[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foods.count
    }
   
 // Ürün başlık seçme
    @IBOutlet weak var IlanVerUrunBaslik: UITextField!
    
    @IBOutlet weak var IlanVerUrunOzellik: UITextField!
    @IBOutlet weak var IlanVerUrunFiyat: UITextField!
    @IBAction func IlanverButon(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textOval(txtField: IlanVerUrunBaslik)
        textOval(txtField: IlanVerUrunOzellik)
        textOval(txtField: IlanVerUrunFiyat)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textOval(txtField: UITextField){
        txtField.layer.cornerRadius = 20
        txtField.layer.borderWidth = 1.0
        txtField.layer.borderColor = UIColor.darkGray.cgColor
    }


}
