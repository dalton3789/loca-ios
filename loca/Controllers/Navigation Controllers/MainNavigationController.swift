//
//  MainNavigationController.swift
//  loca
//
//  Created by Toan Nguyen on 5/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    @IBOutlet weak var navigation: UINavigationBar!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackImage()
    }
    

    func setBackImage(){
        let back = UIBarButtonItem(image: #imageLiteral(resourceName: "back_icon") ,style: .plain, target: self, action: #selector(self.back))
        
        self.navigationItem.leftBarButtonItem = back;
    }
    
    @objc func back(){
        self.popViewController(animated: true)
        print("back")
    }
    
    

}
