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
    var searchController: UISearchController!
    
    lazy var imageView: UIImageView = {
        let logo = UIImage(named: "icn-nav-marvel")
        return UIImageView(image:logo)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = imageView
        
        self.characterPresenter = CharacterPresenter(delegate: self)
        self.characterPresenter.showCharacterList()
        
        let searchResultTableViewController = SearchResultsTableViewController()
        searchResultTableViewController.delegate = self
        
        searchController = UISearchController(searchResultsController: searchResultTableViewController)
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let characterSelected = self.characters[indexPath.row]
        self.performSegueWithIdentifier("segueCharacterDetail", sender: characterSelected)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueCharacterDetail" {
            let detailViewController = segue.destinationViewController as! CharacterDetailViewController
            detailViewController.character = sender as! CharacterViewObject
        }
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
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    }
}

extension CharactersTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let resultsController = searchController.searchResultsController as! SearchResultsTableViewController
        resultsController.results = self.characters
        resultsController.tableView.reloadData()
    }
}

extension CharactersTableViewController: SearchResultsTableDelegate {
    func onCharacterSelected(character: CharacterViewObject) {
        self.searchController.active = false
        self.performSegueWithIdentifier("segueCharacterDetail", sender: character)
    }
}