//
//  chatViewController.swift
//  Flash-Chat
//
//  Created by Rishabh on 20/03/20.
//  Copyright © 2020 Rishabh. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
import SVProgressHUD

class chatViewController: UIViewController , UITableViewDelegate, UITableViewDataSource ,UITextFieldDelegate{

    @IBOutlet weak var heightCons: NSLayoutConstraint!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var messageView: UITableView!
    
    var messArr : [mesage] = [mesage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageView.delegate = self
        messageView.dataSource = self
        // Do any additional setup after loading the view.
        message.delegate = self
        
        messageView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        congifCell()
        retrieve()
        
        let tapges = UITapGestureRecognizer(target: self, action: #selector(tableviewTap))
        messageView.addGestureRecognizer(tapges)
        
        messageView.separatorStyle = .none
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
       
        cell.messageLabel.text = messArr[indexPath.row].message
        cell.userLabel.text = messArr[indexPath.row].sender
        cell.userImage.image = UIImage(named: "egg")
        
    return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messArr.count
    }
    @objc func tableviewTap(){
        message.endEditing(true)
        
    }
    func congifCell(){
        messageView.rowHeight = UITableView.automaticDimension
        messageView.estimatedRowHeight = 120.0
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
        self.heightCons.constant = 308
        self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
            self.heightCons.constant = 50
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func logoutPressed(_ sender: Any) {
        
        print("log out pressed")
        do{
        
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        }
        catch {
            print("Error occured")
        }
    }
    @IBAction func sendPressed(_ sender: Any) {
        message.endEditing(true)
        message.isEnabled = false
        send.isEnabled = false
        
        let mesages = Database.database().reference().child("Messages")
        let messDic = ["Sender" : Auth.auth().currentUser?.email!, "message" : message.text! ]
        
        mesages.childByAutoId().setValue(messDic) { (error, reference) in
            if error != nil {
                print(error!)
            }
            else{
                print("message saved")
                self.message.isEnabled = true
                self.send.isEnabled = true
                self.message.text = " "
                
            }
        }
    }
    
    func retrieve(){
        
        let messDB = Database.database().reference().child("Messages")
        messDB.observe(.childAdded, with : { (snapshot) in
            
            let snapVal = snapshot.value as! Dictionary<String,String>
            let text = snapVal["message"]!
            let sender = snapVal["Sender"]!
            print(text ,sender)
            let mess = mesage()
            mess.message = text
            mess.sender = sender
            
            self.messArr.append(mess)
            
            
            self.congifCell()
            self.messageView.reloadData()
        })
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
