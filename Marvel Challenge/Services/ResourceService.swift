//
//  ResourceService.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol ResourceServiceDelegate {
    func onGetResource(resource: ResourceCharacter)
    func onGetResourceError(error: NSError)
}

class ResourceService: NSObject {
    private let service = BaseService()
    
    var delegate: ResourceServiceDelegate
    
    init(delegate: ResourceServiceDelegate) {
        self.delegate = delegate
    }
    
    func getResource(resourceURI: String) {
        
        service.get(resourceURI) { (json, error) -> Void in
            
            guard error == nil else {
                self.delegate.onGetResourceError(error!)
                return
            }
            
            if let _json = json {
                var resources: [ResourceCharacter] = []
                for (_, subJson):(String, JSON) in _json {
                    resources.append(ResourceCharacter(json: subJson)!)
                }
                
                self.delegate.onGetResource(resources[0])
            }
        }
    }
}
