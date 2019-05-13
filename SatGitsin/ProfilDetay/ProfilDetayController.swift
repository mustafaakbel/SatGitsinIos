//
//  ProfilDetayController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 11.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit
import Firebase
class ProfilDetayController: UIViewController {
    
    @IBOutlet weak var Satilanlar: UIView!
    @IBOutlet weak var Satiliyor: UIView!
    var Kisiuid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KullaniciBul()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func KullaniciBul(){
        let dbRef = Database.database().reference().child("Kullanicilar")
        dbRef.child(Kisiuid).observe(.value, with: { (snapshot) in
            print(snapshot)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SatildiEmbed") {
            let childViewController = segue.destination as! SatildiProfilDetayController
            childViewController.id = Kisiuid
            // Now you have a pointer to the child view controller.
            // You can save the reference to it, or pass data to it.
        }
    }

    @IBOutlet weak var profilDetaySegment: UISegmentedControl!
    
    @IBAction func profilDetaySegmentKontrol(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            Satiliyor.alpha = 1
            Satilanlar.alpha = 0
            break
        case 1:
            Satiliyor.alpha = 0
            Satilanlar.alpha = 1
            break
        default:
            break
        }
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
