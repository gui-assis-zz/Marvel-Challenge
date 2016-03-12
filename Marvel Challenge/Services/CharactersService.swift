//
//  CharactersService.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol CharacterServiceDelegate {
    func onGetCharacters(characters: [Character])
    func onGetCharactersError(error: NSError)
}

class CharactersService: NSObject {
    
    private let path = "public/characters"
    private let service = BaseService()
    
    var delegate: CharacterServiceDelegate
    
    init(delegate: CharacterServiceDelegate) {
        self.delegate = delegate
    }
    
    func getCharacters(){
        service.get(self.path) { (json, error) -> Void in
            
            guard error == nil else {
                self.delegate.onGetCharactersError(error!)
                return
            }
            
            if let _json = json {
                var characters: [Character] = []
                for (_, subJson):(String, JSON) in _json {
                    characters.append(Character(json: subJson)!)
                }
                
                for character in characters {
                    character.printDescription()
                }
                
                self.delegate.onGetCharacters(characters)
            }
        }
    }
}
