//
//  FlatDetailViewController.swift
//  loca
//
//  Created by Toan Nguyen on 5/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class FlatDetailViewController: UIViewController, UIScrollViewDelegate {

    let sharedAction = SharedActions()
    
    @IBOutlet weak var scrollView: UIScrollView!
    var Sides:[UIView] = [];
    
    @IBOutlet weak var pageCotrol: UIPageControl!
    @IBOutlet weak var close_button: UIImageView!
    
    @IBOutlet weak var view_basic: UIView!
    @IBOutlet weak var view_utiliity: UIView!
    @IBOutlet weak var view_image: UIView!
    @IBOutlet weak var view_document: UIView!
    @IBOutlet weak var view_contact: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        Sides = createSides()
        setupSidescrollView(Sides: Sides)
        
        pageCotrol.numberOfPages = Sides.count
        pageCotrol.currentPage = 0
        view.bringSubviewToFront(pageCotrol)
        
        close_button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView)))
        setLayout()
    }
    
    func setLayout(){
        sharedAction.setBorder(view: view_basic)
        sharedAction.setBorder(view: view_utiliity)
        sharedAction.setBorder(view: view_image)
        sharedAction.setBorder(view: view_document)
        sharedAction.setBorder(view: view_contact)
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
    
   
    func createSides() -> [UIView] {
        
        let Side1:Side = Bundle.main.loadNibNamed("Side", owner: self, options: nil)?.first as! Side
        Side1.setLayout()
        
        let ApartmentUtility:ApartmentUtility = Bundle.main.loadNibNamed("ApartmentUtility", owner: self, options: nil)?.first as! ApartmentUtility
        ApartmentUtility.setLayout()
        
        let Side3:Side = Bundle.main.loadNibNamed("Side", owner: self, options: nil)?.first as! Side

        let Side4:Side = Bundle.main.loadNibNamed("Side", owner: self, options: nil)?.first as! Side

        
        let Side5:Side = Bundle.main.loadNibNamed("Side", owner: self, options: nil)?.first as! Side
        
        return [Side1, ApartmentUtility, Side3, Side4, Side5]
    }

    func setupSidescrollView(Sides : [UIView]) {
       // scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.88)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(Sides.count), height: view.frame.height * 2)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< Sides.count {
            Sides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(Sides[i])
        }
    }
    
    
    
    
}
