//
//  SearchResultsTableViewController.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

protocol SearchResultsTableDelegate {
    func onCharacterSelected(character: CharacterViewObject)
}

class SearchResultsTableViewController: UITableViewController {
    
    var results: [CharacterViewObject]!
    var delegate: SearchResultsTableDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.darkGrayColor()
        
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "SearchResultCell")
        tableView.rowHeight = 80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SearchResultCell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell", forIndexPath: indexPath) as! SearchResultCell
        let character = self.results[indexPath.row]
        
        cell.setupWithCharacter(character)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let character = self.results[indexPath.row]
        self.delegate.onCharacterSelected(character)
    }
}
