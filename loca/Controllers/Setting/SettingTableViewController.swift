//
//  SettingTableViewController.swift
//  loca
//
//  Created by Dalton Nguyen on 6/18/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit
import PopupDialog

class SettingTableViewController: UITableViewController {

    var dataList = [settingList]()
    
    struct settingList {
        var icon = UIImage()
        var descriptionInfo = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        dataList.append(settingList.init(icon: UIImage(named: "account_icon")!, descriptionInfo: "Thông Tin Tài Khoản"))
        dataList.append(settingList.init(icon: UIImage(named: "lock_icon")!, descriptionInfo: "Thay Đổi Password"))
        dataList.append(settingList.init(icon: UIImage(named: "account_icon")!, descriptionInfo: "Thong Tin Tai Khoan"))
        
        tableView.reload(animationDirection: .down)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "info_setting") as! SettingTableViewCell
        cell.setData(image: dataList[indexPath.row].icon, description: dataList[indexPath.row].descriptionInfo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showCustomDialog(animated: true)
    }
    
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        
        let ratingVC = ChangePasswordViewController(nibName: "ChangePasswordView", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "HUỶ BỎ", height: 60) {
            //self.label.text = "You canceled the rating dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "XÁC NHẬN", height: 60) {
            if ratingVC.txt_reconfirmpass.text != ratingVC.txt_confirmpass.text {
                self.showStandardDialog(title: "Password khong khop", subTitle: "Vui long nhap khop password moi")
            }
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
    
    func showStandardDialog(animated: Bool = true, title : String, subTitle : String) {
        
        // Prepare the popup
        let title = title
        let message = subTitle
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true,
                                hideStatusBar: true) {
                                    print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL") {
           // self.label.text = "You canceled the default dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "OK") {
            //self.label.text = "You ok'd the default dialog"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }

    
}
