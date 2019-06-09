//
//  SignUpViewController.swift
//  loca
//
//  Created by Toan Nguyen on 6/3/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_password2: UITextField!
    
    @IBOutlet weak var btn_signup: UIButton!
    
    let sharedAction = SharedActions()
    
    var datavalidation = [DataValidation]()
    
    struct DataValidation {
        var isPassed : Bool
        var errorMessage : String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    func setLayout(){
        sharedAction.roundBorder(control: txt_name, width: 1, color: UIColor.clear.cgColor, radius: 15)
        sharedAction.roundBorder(control: txt_email, width: 1, color: UIColor.clear.cgColor, radius: 15)
        sharedAction.roundBorder(control: txt_password, width: 1, color: UIColor.clear.cgColor, radius: 15)
        sharedAction.roundBorder(control: txt_password2, width: 1, color: UIColor.clear.cgColor, radius: 15)
        sharedAction.roundBorder(control: btn_signup, width: 1, color: UIColor.clear.cgColor, radius: 15)
        
    }

    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signup(_ sender: UIButton) {
        validateAllinputs()
    }
    
    func validateAllinputs(){
        self.datavalidation.removeAll()
        if (txt_password2.text == "" || txt_email.text == "" || txt_name.text == "" || txt_password.text == ""){
            self.datavalidation.append(DataValidation.init(isPassed: false, errorMessage: "Vui lòng điền đầy đủ thông tin"))
            sharedAction.showErrorToast(message: "Vui lòng điền đầy đủ thông tin", view: self.view)
        } else if (txt_password2.text! != txt_password.text!) {
            sharedAction.showErrorToast(message: "Password không khớp ", view: self.view)
        }
        else {
            
            let server = Server()
            let data = ["name" : txt_name.text!, "email" : txt_email.text!, "password" : txt_password.text! , "password_confirm" : txt_password2.text!] as [String : Any]
            server.sendHTTPrequsetWithData(data, Config.host + "/api/register")
 
            performSegue(withIdentifier: "home", sender: self)
        }
    }
}
