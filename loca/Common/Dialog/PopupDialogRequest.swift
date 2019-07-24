//
//  PopupDialog.swift
//  loca
//
//  Created by Dalton Nguyen on 7/23/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation
import PopupDialog

class PopupDialogRequest {
    
    class func generateDialog(animated: Bool = true, title : String, subTitle : String, okHandler: @escaping ()->(), cancelHandler: @escaping ()->()) -> PopupDialog {
        
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
            cancelHandler()
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "OK") {
            okHandler()
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        return popup
    }
    
    
}
