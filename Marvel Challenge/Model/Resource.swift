//
//  Resource.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

class Resource: ResponseObjectSerializable {
    
    var id: Int
    var title: String
    var description: String
    var thumbnail: Thumbnail
    
    required init?(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        self.thumbnail = Thumbnail(json: json["thumbnail"])!
    }
}