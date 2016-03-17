//
//  CustomProtocol.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 16/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CustomProtocol: NSURLProtocol {
    override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        print("Request: \(request.URL!.absoluteString)")
        return false
    }
}