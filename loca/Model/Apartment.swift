//
//  Apartment.swift
//  loca
//
//  Created by iMac 01 on 6/11/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation


class ApartmentData {
    
    struct aparatmentStruct {
        var id : Int
        var addressNumber : String
        var longitude : String
        var lattitude : String
        var address : String
        var area : String
        var ward : String?
        var district : String?
        var city : String?
        var legalStatus : String
        var areaSquare : String
        var fontStreet : String
        var direction : String
        var floor : String
        var bedroom : String
        var bathroom : String
        var terrace : String
        var garden : String
        var pool : String
        var estateType : String
        var descriptiom : String
        var ownerName : String
        var ownerNumber : String
        var period : [costPeriod]
        var utilities : [utilities]
        var documentType : String
        var documentPhoto : [documentPhoto]
        var contactName : String
        var contactNumber : String
        var apartmentPhotos : [apartmentPhotos]
        
    }
    
    struct costPeriod : Codable {
        var period : String
        var cost : String
        var concurrency : String
    }
    
    struct utilities : Codable {
        var utility : String
    }
    
    struct documentPhoto : Codable {
        var photoLink : String
    }
    
    struct apartmentPhotos : Codable {
        var photoLink : String
    }
    
}
