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

}
