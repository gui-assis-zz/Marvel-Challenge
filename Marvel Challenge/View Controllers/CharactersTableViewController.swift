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
    var isLoading: Bool = false
    
    lazy var imageView: UIImageView = {
        let logo = UIImage(named: "icn-nav-marvel")
        return UIImageView(image:logo)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = imageView
        
        characterPresenter = CharacterPresenter(delegate: self)
        loadData(offset: 0)
        
        let searchResultTableViewController = SearchResultsTableViewController()
        searchResultTableViewController.delegate = self
        
        searchController = UISearchController(searchResultsController: searchResultTableViewController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = true
        
        extendedLayoutIncludesOpaqueBars = true
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
    }
    
    func loadData(offset offset: Int, characterName: String? = nil){
        isLoading = true
        
        if let name = characterName {
            characterPresenter.searchCharacterWithName(name)
        } else {
            characterPresenter.showCharacterList(offset)
        }
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
        return characters.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCellWithIdentifier("CharacterCell", forIndexPath: indexPath) as! CharacterCell
        let character = self.characters[indexPath.row]
        cell.setupWithCharacter(character)
        
        if indexPath.row >= characters.count - 5 && !isLoading {
            isLoading = true
            self.loadData(offset: characters.count)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let characterSelected = self.characters[indexPath.row]
        self.performSegueWithIdentifier("segueCharacterDetail", sender: characterSelected)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueCharacterDetail" {
            let detailViewController = segue.destinationViewController as! CharacterDetailTableViewController
            detailViewController.character = sender as! CharacterViewObject
        }
    }
    
    //MARK: Private methods
    @IBAction func btnSearchClick(sender: AnyObject) {
        self.searchController.active = true
    }
}

extension CharactersTableViewController: CharacterPresenterDelegate {
    
    func onGetCharacterSearchList(characters: [CharacterViewObject]) {
        self.isLoading = false
        
        let resultsController = searchController.searchResultsController as! SearchResultsTableViewController
        resultsController.results.removeAll()
        resultsController.results.appendContentsOf(characters)
        resultsController.tableView.reloadData()
    }
    
    func onGetCharacterList(characters: [CharacterViewObject]) {
        self.isLoading = false
        self.characters.appendContentsOf(characters)
        self.tableView.reloadData()
    }
    
    func onGetCharacterListError(message: String) {
        self.isLoading = false
    }
}

extension CharactersTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    }
}

extension CharactersTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        loadData(offset: 0, characterName: searchController.searchBar.text)
    }
}

extension CharactersTableViewController: SearchResultsTableDelegate {
    func onCharacterSelected(character: CharacterViewObject) {
        self.performSegueWithIdentifier("segueCharacterDetail", sender: character)
    }
}