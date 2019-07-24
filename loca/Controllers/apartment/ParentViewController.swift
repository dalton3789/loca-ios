//
//  ParentViewController.swift
//  loca
//
//  Created by Toan Nguyen on 6/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import ISHPullUp

class ParentViewController: ButtonBarPagerTabStripViewController, ISHPullUpSizingDelegate, ISHPullUpStateDelegate{

    var isReload = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtonBar()
    }
    

    func configureButtonBar() {
        // set up style before super view did load is executed
        settings.style.buttonBarBackgroundColor = .gray
        settings.style.selectedBarBackgroundColor = .cyan
        //-
        super.viewDidLoad()
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(white: 1, alpha: 0.6)
            newCell?.label.textColor = .white
            
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            } else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ApartmentBasicViewController") as! ApartmentBasicViewController
        
        let child_4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ApartmentPremiumViewController") as! ApartmentPremiumViewController
        
        guard isReload else {
            return [child_2, child_4]
        }
        
        var childViewControllers = [child_2, child_4]
        
        for index in childViewControllers.indices {
            let nElements = childViewControllers.count - index
            let n = (Int(arc4random()) % nElements) + index
            if n != index {
                childViewControllers.swapAt(index, n)
            }
        }
        let nItems = 1 + (arc4random() % 8)
        return Array(childViewControllers.prefix(Int(nItems)))
    }
    
    override func reloadPagerTabStripView() {
        isReload = true
        if arc4random() % 2 == 0 {
            pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        } else {
            pagerBehaviour = .common(skipIntermediateViewControllers: arc4random() % 2 == 0)
        }
        super.reloadPagerTabStripView()
    }
    
    override func configureCell(_ cell: ButtonBarViewCell, indicatorInfo: IndicatorInfo) {
        super.configureCell(cell, indicatorInfo: indicatorInfo)
        cell.backgroundColor = .clear
    }
    
    weak var pullUpController: ISHPullUpViewController!
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {
        return 100
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
        return 800
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
        
        if height < 50 {
            self.dismiss(animated: true, completion: nil)
            return 0
        }
        return height
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forBottomViewController contentVC: UIViewController) {
        // containerView.contentInset = edgeInsets
        
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
        print("Change")
    }

}
