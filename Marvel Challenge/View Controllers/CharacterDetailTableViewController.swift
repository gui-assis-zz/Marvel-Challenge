//
//  CharacterDetailTableViewController.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import MXParallaxHeader

class CharacterDetailTableViewController: UITableViewController {
    
    var character: CharacterViewObject!
    var rows: Int = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "icn-nav-back-white"), style: .Done, target: navigationController, action: Selector("popViewControllerAnimated:"))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = character.name
        
        let imgHeader = UIImageView()
        imgHeader.loadImageWithUrl(character.thumbnail, placeholder: nil, reloadCache: false)
        imgHeader.contentMode = .ScaleAspectFill
        
        tableView.parallaxHeader.view = imgHeader
        tableView.parallaxHeader.height = (self.view.frame.size.height * 60)/100
        tableView.parallaxHeader.mode = .Fill
        tableView.parallaxHeader.minimumHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imgHeader.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let imgBackground = UIImageView()
        imgBackground.loadImageWithUrl(character.thumbnail, placeholder: nil, reloadCache: false)
        imgBackground.contentMode = .ScaleAspectFill
        imgBackground.addSubview(blurEffectView)
        tableView.backgroundView = imgBackground
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 6 {
            return 3
        }
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("indexPath: \(indexPath.section)")
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SimpleTextTableViewCell", forIndexPath: indexPath) as! SimpleTextTableViewCell
            cell.setupWithText(character.name ?? "")
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SimpleTextTableViewCell", forIndexPath: indexPath) as! SimpleTextTableViewCell
            cell.setupWithText(character.characterDescription ?? "No description available")
            return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell", forIndexPath: indexPath) as! CollectionTableViewCell
            cell.setupWithCollection(character.comics)
            return cell
        }
        
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell", forIndexPath: indexPath) as! CollectionTableViewCell
            cell.setupWithCollection(character.series)
            return cell
        }
        
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell", forIndexPath: indexPath) as! CollectionTableViewCell
            cell.setupWithCollection(character.stories)
            return cell
        }
        
        if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell", forIndexPath: indexPath) as! CollectionTableViewCell
            cell.setupWithCollection(character.events)
            return cell
        }
        
        if indexPath.section == 6 {
            let urlVO = character.urls[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("LinksTableViewCell", forIndexPath: indexPath) as! LinksTableViewCell
            cell.setupWithUrlVO(urlVO)
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1 {
            return 70
        }
        
        if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 {
            return 220
        }
        
        return 51
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

extension CharacterDetailTableViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}