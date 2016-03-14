//
//  Collection.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class Collection: NSObject {
    var collectionType: CollectionType
    var items: [CollectionItem]
    
    init(collectionType: CollectionType, items: [CollectionItem]) {
        self.collectionType = collectionType
        self.items = items
    }
}
