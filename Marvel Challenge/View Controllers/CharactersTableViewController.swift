//
//  CharactersTableViewController.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    var characters: [CharacterViewObject] = []
    var characterPresenter: CharacterPresenter!
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var imageView: UIImageView = {
        let logo = UIImage(named: "icn-nav-marvel")
        return UIImageView(image:logo)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = imageView
        
        self.characterPresenter = CharacterPresenter(delegate: self)
        self.characterPresenter.showCharacterList()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = true
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.definesPresentationContext = true
        
        self.tableView.tableHeaderView = searchController.searchBar
        
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
        return self.characters.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCellWithIdentifier("CharacterCell", forIndexPath: indexPath) as! CharacterCell
        let character = self.characters[indexPath.row]
        cell.setupWithCharacter(character)
        return cell
    }
    
    //MARK: Private methods
    @IBAction func btnSearchClick(sender: AnyObject) {
        self.searchController.active = true
    }
}

extension CharactersTableViewController: CharacterPresenterDelegate {
    
    func onGetCharacterList(characters: [CharacterViewObject]) {
        self.characters.removeAll()
        self.characters.appendContentsOf(characters)
        self.tableView.reloadData()
    }

    
    func onGetCharacterListError(message: String) {
        print(message)
    }
}

extension CharactersTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    }
}

extension CharactersTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
//        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}