//
//  GalleryCollectionViewCell.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 16/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCollection: UIImageView!
    
    func setupWithCollectionItem(collectionItem: CollectionItem) {
        imgCollection.hidden = true
        let resourcePresenter = ResourcePresenter(delegate: self)
        resourcePresenter.getResourceDetail(collectionItem.resourceURI)
    }
}

extension GalleryCollectionViewCell: ResourcePresenterDelegate {
    
    func onGetResourceItem(resourceItem: ResourceItem) {
        imgCollection.image = resourceItem.resourceImage
        imgCollection.hidden = false
    }
    
    func onGetResourceItemErro(error: NSError) {
        
    }
}
