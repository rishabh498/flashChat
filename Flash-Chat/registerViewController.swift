//
//  registerViewController.swift
//  Flash-Chat
//
//  Created by Rishabh on 20/03/20.
//  Copyright © 2020 Rishabh. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class registerViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func resgiterPressed(_ sender: Any) {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if error != nil{
                print(error!)
            }
            else{
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
