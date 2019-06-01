//
//  SharedActions.swift
//  loca
//
//  Created by Toan Nguyen on 5/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation
import UIKit


class SharedActions {
    var view : UIView?
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    func showAlert(view : UIViewController, title : String , alert : String){
        // create the alert
        let alert = UIAlertController(title: title, message: alert, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    
    public func setBottomBorder(view : UIView) {
        //view.borderStyle = .none
        view.layer.backgroundColor = UIColor.white.cgColor
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UITableView().separatorColor?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 0.0
    }
    
    public func setBottomBorder(view : UIView, lineColor : UIColor) {
        //view.borderStyle = .none
        view.layer.backgroundColor = UIColor.white.cgColor
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = lineColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 0.0
    }
    
    public func setBorder(view: UIView){
        view.layer.masksToBounds = true
        view.layer.borderColor = UITableView().separatorColor?.cgColor
        view.layer.borderWidth = 1.0
    }
    
    
    func roundBorder(control : UIView, width : CGFloat, color : CGColor, radius : CGFloat ){
        control.layer.borderWidth = width
        control.layer.borderColor = color
        control.layer.cornerRadius = radius
    }
    
    func getSharedData(key : String) -> String {
        
        if let value = UserDefaults.standard.string(forKey: key ){
            return value
        }
        return ""
    }
    
    func setTransparentNavigation(view : UIViewController){
        view.navigationController?.navigationBar.isTranslucent = true
        view.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        view.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    func allignKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view!.frame.origin.y == 0 {
                self.view!.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view!.frame.origin.y != 0 {
            self.view!.frame.origin.y = 0
        }
    }
    
    func getCurrentTime() -> String{
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        return String(hour) + ":" + String(minutes)
    }
    
    func getCurrentDate() -> String{
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        return String(day) + "-" + String(month) + "-" + String(year)
    }
    
    func showToast(message : String, view: UIView) {
        
        let toastLabel = UILabel(frame: CGRect(x: 16, y: view.frame.size.height-100, width: view.frame.size.width - 32, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    func showErrorToast(message : String, view: UIView) {
        
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 15.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 0;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            //toastLabel.alpha = 0.0
            toastLabel.frame = CGRect(x: 0, y: 30, width:view.frame.size.width, height: 45)
        }, completion: {(isCompleted) in
            
            UIView.animate(withDuration: 4.0, animations: {
                toastLabel.alpha = 0.0
            }, completion : {isCompleted in
                toastLabel.removeFromSuperview()
            })
            
        })
    }
    
    func showErrorToast(message : String, view: UIView, startY : CGFloat, endY : CGFloat) {
        
        let toastLabel = UILabel(frame: CGRect(x: 0, y: startY, width: view.frame.size.width, height: 45))
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 15.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 0;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            //toastLabel.alpha = 0.0
            toastLabel.frame = CGRect(x: 0, y: endY, width:view.frame.size.width, height: 45)
        }, completion: {(isCompleted) in
            
            UIView.animate(withDuration: 4.0, animations: {
                toastLabel.alpha = 0.0
            }, completion : {isCompleted in
                toastLabel.removeFromSuperview()
            })
            
        })
    }
    
    func showConfirmAlert(view : UIViewController, title : String , alert : String, confirmAction: @escaping () -> () ){
        // create the alert
        let alert = UIAlertController(title: title, message: alert, preferredStyle: UIAlertController.Style.actionSheet)
        
        // add an action (button)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {
            action in
            confirmAction()
        }))
        
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    
    func showPremiumAccountError(view : UIViewController, title : String , alert : String, confirmAction: @escaping () -> () ){
        
        let alert = UIAlertController(title: title, message: alert, preferredStyle: UIAlertController.Style.actionSheet)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            action in
            let viewBlank = UIView(frame: CGRect(x: 0, y: 0, width: view.view.frame.width, height: view.view.frame.height))
            view.view.addSubview(viewBlank)
            view.view.bringSubviewToFront(viewBlank)
            
        }))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {
            action in
            confirmAction()
        }))
        
        // show the alert
        view.present(alert, animated: true, completion: nil)
        
    }
    
}
