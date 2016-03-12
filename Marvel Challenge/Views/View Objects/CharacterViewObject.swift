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
    var characterId: Int
    
    init(name: String, thumbnail: String, characterId: Int) {
        self.name = name
        self.thumbnail = thumbnail
        self.characterId = characterId
    }
}