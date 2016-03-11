//
//  Url.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

enum UrlType: String {
    case detail = "detail"
    case wiki = "wiki"
    case comiclink = "comiclink"
}

class Url: ResponseObjectSerializable {
    
    var urlType: UrlType
    var url: String
    
    required init?(json: JSON) {
        self.url = json["url"].stringValue
        self.urlType = UrlType(rawValue: json["urlType"].stringValue) ?? UrlType.detail
    }
}
