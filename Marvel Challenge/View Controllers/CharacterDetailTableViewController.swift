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
        
        self.addBlurEffect()
        
        let imgCharacter = UIImageView()
        imgCharacter.loadImageWithUrl(character.thumbnail, placeholder: nil, reloadCache: false)
        imgCharacter.contentMode = .ScaleAspectFill
        
        
//        tableView.parallaxHeader.view = imgCharacter
//        tableView.parallaxHeader.height = (self.view.frame.size.height * 60)/100
//        tableView.parallaxHeader.mode = .Fill
//        tableView.parallaxHeader.minimumHeight = 0
        
        tableView.tableHeaderView = imgCharacter
    }
    
    func addBlurEffect() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.view.backgroundColor = UIColor.clearColor()
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
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = String(format: "Height %ld", indexPath.row * 10)
        return cell
    }
}
