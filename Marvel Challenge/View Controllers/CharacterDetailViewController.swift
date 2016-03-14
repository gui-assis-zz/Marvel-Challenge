//
//  CharacterDetailViewController.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var character: CharacterViewObject!
    
    @IBOutlet weak var imgBlurBackground: UIImageView!
    @IBOutlet weak var seriesCollection: UICollectionView!
    @IBOutlet weak var eventsCollection: UICollectionView!
    @IBOutlet weak var comicsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(named: "icn-nav-back-white"), style: .Done, target: navigationController, action: Selector("popViewControllerAnimated:"))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = character.name
        
//        navigationController?.setNavigationBarHidden(true, animated: true)
        
        imgBlurBackground.loadImageWithUrl(character.thumbnail, placeholder: nil, reloadCache: false)
        imgBlurBackground.contentMode = .ScaleToFill
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imgBlurBackground.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        imgBlurBackground.addSubview(blurEffectView)
        
        seriesCollection.delegate = self
        seriesCollection.dataSource = self
        eventsCollection.delegate = self
        eventsCollection.dataSource = self
        comicsCollection.delegate = self
        comicsCollection.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

extension CharacterDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if scrollView.contentOffset.y <= 44 {
//            navigationController?.setNavigationBarHidden(true, animated: true)
//        } else {
//            navigationController?.setNavigationBarHidden(false, animated: true)
//        }
    }
}

extension CharacterDetailViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == seriesCollection {
            return character.series.items.count
        }
        
        if collectionView == eventsCollection {
            return character.events.items.count
        }
        
        if collectionView == comicsCollection {
            return character.comics.items.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        if collectionView == seriesCollection {
            let serieItem = self.character.series.items[indexPath.row]
            cell.setupWithResourceURI(serieItem.resourceURI)
        }
        
        if collectionView == eventsCollection {
            let eventItem = self.character.events.items[indexPath.row]
            cell.setupWithResourceURI(eventItem.resourceURI)
        }
        
        if collectionView == comicsCollection {
            let comicItem = self.character.comics.items[indexPath.row]
            cell.setupWithResourceURI(comicItem.resourceURI)
        }
        
        return cell
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate {
    
}










