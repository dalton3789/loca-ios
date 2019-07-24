//
//  LocaProjectAPI.swift
//  loca
//
//  Created by Dalton Nguyen on 7/23/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import Foundation

class LocaProjectAPI {
    class func getProjectList(handler: @escaping (Data)->()){
        let link = Config.host + "/api/projects"
        AlamorefireRequest.send(url: link,
                                method: .get,
                                sucessHandler:{data in handler(data) },
                                errorHandler: {Message.displayToast("Error", withTitle: "Có lỗi. Vui lòng thử lại sau!", type: .error)})
    }
    
}
