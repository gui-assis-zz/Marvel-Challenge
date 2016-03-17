//
//  GalleryViewController.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 16/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var lblPageNumber: UILabel!
    @IBOutlet weak var lblCollectionItemName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var collection: Collection!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        lblCollectionItemName.text = collection.items[0].name
        lblPageNumber.text = "1/\(collection.items.count)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func btnCloseClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collection.items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        
        let collectionItem = self.collection.items[indexPath.row]
        cell.setupWithCollectionItem(collectionItem)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        let currentPage = collectionView.contentOffset.x / pageWidth
        
        if fmodf(Float(currentPage), 1.0) == 0.0 {
            let page = Int(currentPage + 1)
            let item = collection.items[page-1]
            lblCollectionItemName.text = item.name
            lblPageNumber.text = "\(page)/\(collection.items.count)"
        }
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width  = self.collectionView.frame.size.width
        let height = self.collectionView.frame.size.height * 0.9
        return CGSizeMake(width, height)
    }
}
