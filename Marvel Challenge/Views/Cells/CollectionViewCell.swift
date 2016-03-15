//
//  CollectionViewCell.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 14/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCollection: UIImageView!
    @IBOutlet weak var lblCollectionName: UILabel!
    
    func setupWithCollectionItem(collectionItem: CollectionItem) {
        let resourcePresenter = ResourcePresenter(delegate: self)
        resourcePresenter.getResourceDetail(collectionItem.resourceURI)
    }
}

extension CollectionViewCell: ResourcePresenterDelegate {
    
    func onGetResourceItem(resourceItem: ResourceItem) {
        self.imgCollection.image = resourceItem.resourceImage
        self.lblCollectionName.text = resourceItem.title
    }
    
    func onGetResourceItemErro(error: NSError) {
        
    }
}
