//
//  ResourceItem.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 14/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class ResourceItem: NSObject {
    var resourceImage: UIImage
    var title: String
    
    init(resourceImage: UIImage, title: String) {
        self.resourceImage = resourceImage
        self.title = title
    }
}
