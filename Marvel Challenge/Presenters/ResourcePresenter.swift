//
//  ResourcePresenter.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 14/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

protocol ResourcePresenterDelegate {
    func onGetResourceItem(resourceItem: ResourceItem)
    func onGetResourceItemErro(error: NSError)
}

class ResourcePresenter: NSObject {
    
    var delegate: ResourcePresenterDelegate
    var service: ResourceService!
    
    init(delegate: ResourcePresenterDelegate) {
        self.delegate = delegate
    }
    
    func getResourceDetail(resourceURI: String) {
        service = ResourceService(delegate: self)
        service.getResource(resourceURI)
    }
}

extension ResourcePresenter: ResourceServiceDelegate {
    func onGetResource(resource: Resource) {
        ImageHelper.loadImageWithUrl(resource.thumbnail.getThumbUrl(), reloadCache: true) { (image) -> Void in
            if let _image = image {
                let resourceItem = ResourceItem(resourceImage: _image, title: resource.title)
                self.delegate.onGetResourceItem(resourceItem)
            }
        }
    }
    
    func onGetResourceError(error: NSError) {
        self.delegate.onGetResourceItemErro(error)
    }
}
