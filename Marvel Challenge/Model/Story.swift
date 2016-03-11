//
//  Story.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

enum StoryType: String {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

class Story: ResponseObjectSerializable {
    
    var resourceURI: String
    var name: String
    var type: StoryType
    
    required init?(json: JSON) {
        self.resourceURI = json["resourceURI"].stringValue
        self.name = json["name"].stringValue
        self.type = StoryType(rawValue: json["type"].stringValue) ?? StoryType.cover
    }
}