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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = String(format: "Height %ld", indexPath.row * 10)
        return cell
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

extension CharacterDetailTableViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        navigationController?.setNavigationBarHidden(true, animated: true)
//        navigationController?.navigationBar.barTintColor = UIColor.clearColor()
//        navigationController?.view.backgroundColor = UIColor.clearColor()
        
    }
    
    override func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}