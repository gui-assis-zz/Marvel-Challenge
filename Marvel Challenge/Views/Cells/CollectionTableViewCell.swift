//
//  CollectionTableViewCell.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var collection: Collection!
    
    
    func setupWithCollection(collection: Collection) {
        self.collection = collection
        self.collectionView.dataSource = self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collection.items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        let collectionItem = self.collection.items[indexPath.row]
        cell.setupWithCollectionItem(collectionItem)
        
        return cell
    }
}
