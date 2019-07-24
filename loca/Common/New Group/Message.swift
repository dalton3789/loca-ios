//
//  Message.swift
//  loca
//
//  Created by Dalton Nguyen on 7/23/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation
import SwiftMessages

class Message {
    class func displayToast(_ message: String, withTitle title: String, type: Theme) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(type)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: title, body: message)
        SwiftMessages.show(view: view)
    }
}
