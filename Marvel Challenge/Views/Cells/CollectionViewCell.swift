//
//  CollectionViewCell.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCollection: UIImageView!
    @IBOutlet weak var lblCollectionName: UILabel!
    
    func setupWithCollection(collectionItem: CollectionItem) {
        self.imgCollection.loadImageWithUrl(collectionItem.thumbnail, placeholder: nil, reloadCache: true)
        self.lblCollectionName.text = collectionItem.name
    }
}
