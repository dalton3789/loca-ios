//
//  MapNavigationViewController.swift
//  loca
//
//  Created by Dalton Nguyen on 7/23/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit
import ISHPullUp

class MapNavigationViewController: ISHPullUpViewController {

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
        contentDelegate = contentVC
        sizingDelegate = bottomVC
        stateDelegate = bottomVC
    }

}
