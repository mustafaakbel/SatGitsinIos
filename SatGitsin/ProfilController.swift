//
//  ProfilController.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 30.04.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit

class ProfilController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CikisYap(_ sender: Any) {
        //try! Auth.auth().signOut()
        let anasayfa = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = anasayfa
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
