//
//  FlatDetailViewController.swift
//  loca
//
//  Created by Toan Nguyen on 5/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class FlatDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var table: UITableView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
    }
    
    @objc func close(){
        //self.navigationController?.popViewController(animated: true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "detail")!
            return cell
        }
        if indexPath.row == 1 {
           cell = tableView.dequeueReusableCell(withIdentifier: "header")!
            return cell
        }
        if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "overview")!
            cell.isUserInteractionEnabled = true
            return cell
        }
        cell = tableView.dequeueReusableCell(withIdentifier: "header")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    

}
