//
//  UserActions.swift
//  loca
//
//  Created by Toan Nguyen on 6/1/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation


public class UserAction{
    
    public func isPremiumAccount() -> Bool{
        let result = UserData().GetUser()
        
        if result.count == 0 {
            return false
        } else {
            return result.first!.isPremium
        }
        
    }
    
    class func checkPremiumAccount() {
        let userData = UserData()
        if userData.GetUser().count > 0 {
            let id = (UserData().GetUser().first?.id)!
            
            let link = Config.host + "/api/checkpremium?id=" + String(id)
            
            Server().sendGETRequest(link: link, completionhandler: {result in })
        }
        
    }

}
