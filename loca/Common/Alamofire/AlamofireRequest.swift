//
//  AlamofireRequest.swift
//  loca
//
//  Created by Dalton Nguyen on 7/23/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation
import Alamofire

class AlamorefireRequest {
    class func send(url: String, method: HTTPMethod, sucessHandler: @escaping (Data)->(), errorHandler: @escaping ()->()){
        Alamofire.request(url, method: method).responseJSON { response in
            switch response.result {
            case .success:
                sucessHandler(response.data!)
            case .failure:
                errorHandler()
            }
        }
    }
}
