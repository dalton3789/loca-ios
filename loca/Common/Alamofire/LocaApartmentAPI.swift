//
//  LocaApartmentAPI.swift
//  loca
//
//  Created by Dalton Nguyen on 7/23/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation


class LocaApartmentAPI {
    class func getApartment(link: String, completionHandler: @escaping (Data)->()){
        AlamorefireRequest.send(url: link,
                                method: .get,
                                sucessHandler: {data in completionHandler(data)},
                                errorHandler: {Message.displayToast("Error", withTitle: "Có lỗi. Vui lòng thử lại sau!", type: .error)})
    }
}
