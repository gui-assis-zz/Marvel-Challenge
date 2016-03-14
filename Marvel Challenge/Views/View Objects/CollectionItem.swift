//
//  CollectionItem.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CollectionItem: NSObject {
    var thumbnail: String
    var name: String
    
    init(thumbnail: String, name: String) {
        self.thumbnail = thumbnail
        self.name      = name
    }
}