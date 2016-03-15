//
//  UrlVO.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 14/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class UrlVO: NSObject {
    var urlType: UrlType!
    var link: String!
    
    init(urlType: UrlType, link: String) {
        self.urlType = urlType
        self.link = link
    }
}