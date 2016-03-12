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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "icn-nav-marvel")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.characterPresenter = CharacterPresenter(delegate: self)
        self.characterPresenter.showCharacterList()
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