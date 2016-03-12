//
//  Paginator.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

public class Paginator: NSObject {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    
    init(offset: Int, limit: Int, total: Int, count: Int) {
        self.offset = offset
        self.limit  = limit
        self.total  = total
        self.count  = count
    }
}
