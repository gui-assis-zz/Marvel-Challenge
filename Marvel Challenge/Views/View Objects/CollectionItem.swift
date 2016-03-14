//
//  CollectionItem.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CollectionItem: NSObject {
    var resourceURI: String
    var name: String
    
    init(resourceURI: String, name: String) {
        self.resourceURI = resourceURI
        self.name      = name
    }
}