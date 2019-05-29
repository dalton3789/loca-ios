//
//  Config.swift
//  loca
//
//  Created by Toan Nguyen on 5/29/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation

public class Config {
     static let host = "http://192.168.1.224/new/loca/public"
    
    
    public struct apartment {
        var legalStatus = ""
        var longitude = ""
        var latitude = ""
        var id = 0
        var addressNumber = ""
        var projectaddressnumber = ""
        var street = ""
        var addressarea = ""
        var ward = ""
        var district = ""
        var city = ""
        var area = 0
        var frontStreet = ""
        var direction = ""
        var floorNumber = 0
        var bedroom = ""
        var bathroom = ""
        var terrance = ""
        var garden = ""
        var pool = ""
    }
}
