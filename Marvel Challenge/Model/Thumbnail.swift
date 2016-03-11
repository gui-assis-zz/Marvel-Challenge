//
//  Thumbnail.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

class Thumbnail: ResponseObjectSerializable {
    
    var path: String
    var imageExtension: String
    
    required init?(json: JSON) {
        self.path = json["path"].stringValue
        self.imageExtension = json["extension"].stringValue
    }
}
