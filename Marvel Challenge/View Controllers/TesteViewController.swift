//
//  TesteViewController.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class TesteViewController: UIViewController, CharacterServiceDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnTesteClick(sender: AnyObject) {
        let service = CharactersService(delegate: self)
        
        service.getCharacters()
    }
    
    func onGetCharacters(characters: [Character]) {
        
    }
    
    func onGetCharactersError(error: NSError) {
        
    }
    
}
