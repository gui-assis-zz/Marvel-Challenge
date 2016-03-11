//
//  Serie.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

class Serie: ResponseObjectSerializable {
    
    var resourceURI: String
    var name: String
    
    required init?(json: JSON) {
        self.resourceURI = json["resourceURI"].stringValue
        self.name = json["name"].stringValue
    }
}
