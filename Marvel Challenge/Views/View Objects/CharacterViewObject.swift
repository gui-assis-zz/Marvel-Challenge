//
//  CharacterViewObject.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CharacterViewObject: NSObject {
    var name: String
    var thumbnail: String
    
    init(name: String, thumbnail: String) {
        self.name = name
        self.thumbnail = thumbnail
    }
}
