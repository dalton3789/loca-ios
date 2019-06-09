//
//  LoginViewController.swift
//  loca
//
//  Created by Toan Nguyen on 6/3/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_register: UIButton!
    
    let shareAction = SharedActions()
    let server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shareAction.roundBorder(control: txt_username, width: 1, color: UIColor.clear.cgColor, radius: 15)
        shareAction.roundBorder(control: txt_password, width: 1, color: UIColor.clear.cgColor, radius: 15)
        shareAction.roundBorder(control: btn_login, width: 1, color: UIColor.clear.cgColor, radius: 15)
        shareAction.roundBorder(control: btn_register, width: 1, color: UIColor.clear.cgColor, radius: 15)
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        if txt_username.text == "" {
        shareAction.showErrorToast(message: "Email không được trống", view: self.view, startY: txt_username.frame.minY, endY: txt_username.frame.minY - 50)
        }
        else if txt_password.text == "" {
        shareAction.showErrorToast(message: "Password không được trống", view: self.view, startY: txt_password.frame.minY, endY: txt_password.frame.minY - 50)
        } else{
            let data = ["email" : txt_username.text!, "password" : txt_password.text!] as [String:Any]
            let link = Config.host + "/api/login"
           
            server.sendHTTPrequsetWithData(data, link, complitionHandler: {result in
                self.getUserDetail(result: result)
        })
            
        }
    }
    
    func getUserDetail(result : String){
        
        let data = result.data(using: .utf8)!
        do {
            let user = UserData()
            
            
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                user.DeleteAllUser()
                for event in jsonArray {
                    
                    let name = event["name"] as! String
                    let id = event["id"] as! Int
                    let email = event["email"] as! String
                    let password = event["password"] as! String
                    let role = event["role"] as! String
                    
                    user.AddUser(name, id, email, password, role)
                }
                
                DispatchQueue.main.async{
                    
                }
                
            } else {
                print("bad json")
                DispatchQueue.main.async{
                    self.shareAction.showErrorToast(message: "Lỗi! Vui lòng thử lại sau", view: self.view, startY: 40, endY: 90)
                }
                
            }
        } catch let error as NSError {
            print(error)
            DispatchQueue.main.async{
                self.shareAction.showErrorToast(message: "Lỗi! Vui lòng thử lại sau", view: self.view, startY: 40, endY: 90)
            }
        }
        
    }
    
    
    
    
    


}
