//
//  MainTabViewController.swift
//  loca
//
//  Created by Toan Nguyen on 6/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit
import ISHPullUp

class MainTabViewController: ISHPullUpViewController {

    var project : Project?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let contentVC = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let bottomVC = storyBoard.instantiateViewController(withIdentifier: "ParentViewController") as! ParentViewController
        contentVC.project = project!
        contentViewController = contentVC
        bottomViewController = bottomVC
        bottomVC.pullUpController = self
        contentDelegate = contentVC as? ISHPullUpContentDelegate
        sizingDelegate = bottomVC
        stateDelegate = bottomVC
 
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
