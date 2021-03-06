//
//  ApartmentPremiumViewController.swift
//  loca
//
//  Created by Toan Nguyen on 6/1/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class ApartmentPremiumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {
    
    
    
    let sharedAction = SharedActions()
    
    @IBOutlet weak var tableView: UITableView!
    var viewBlank = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkPremiumAccout()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let itemInfo: IndicatorInfo = "Nâng Cao"
        return itemInfo
    }
    
    func checkPremiumAccout(){
        let isPremium = UserAction().isPremiumAccount()
        
       viewBlank = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        viewBlank.backgroundColor = UIColor.white
        self.view.addSubview(viewBlank)
    
        if !isPremium{
           // sharedAction.showPremiumAccountError(view: self, title: "Nâng Cấp Lên Premium Account", alert: "Tính năng chỉ dành riêng cho Premium Account", confirmAction: navigateToMain)
            Message.displayToast("Tính năng chỉ dành riêng cho Premium Account", withTitle: "Error" , type: .error)

            let popup = PopupDialogRequest.generateDialog(title: "Error", subTitle: "Nâng Cấp Lên Premium Account", okHandler: {}, cancelHandler: {})
            guard let nav = self.navigationController else {
                print("Empty")
                return
            }
            nav.present(popup, animated: true)
        }else{
            self.viewBlank.removeFromSuperview()
        }
    }
    
    func navigateToMain(){
        print("Blank")
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3 :
            return 90
        default:
            return 50
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "apartment_contact") as! ApartmentContactTableViewCell
            
            cell.setData(name: "Nguyen Dinh Toan", phone: "0909499240")
            return cell
        }
        
        return cell
    }

}
