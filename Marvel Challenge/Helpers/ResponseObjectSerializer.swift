//
//  ResponseObjectSerializer.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

public protocol ResponseObjectSerializable {
    init?(json : JSON)
}
