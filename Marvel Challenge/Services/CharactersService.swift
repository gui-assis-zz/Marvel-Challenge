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
    
    func getCharacters(offset: Int, characterName: String? = nil){
        
        var parameters: [String: AnyObject]?
        
        if let _name = characterName {
            parameters = ["nameStartsWith": _name]
        }
        
        service.get(self.path, offset: offset, parameters: parameters) { (json, error) -> Void in
            
            guard error == nil else {
                self.delegate.onGetCharactersError(error!)
                return
            }
            
            if let _json = json {
                var characters: [Character] = []
                for (_, subJson):(String, JSON) in _json {
                    characters.append(Character(json: subJson)!)
                }
                
                self.delegate.onGetCharacters(characters)
            }
        }
    }
}
