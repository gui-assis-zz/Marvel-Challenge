//
//  CharacterPresenter.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

protocol CharacterPresenterDelegate {
    func onGetCharacterList(characters: [CharacterViewObject])
    func onGetCharacterListError(message: String)
    func onGetCharacterSearchList(characters: [CharacterViewObject])
}

enum ServiceType {
    case Search
    case List
}

class CharacterPresenter: NSObject {
    
    var delegate: CharacterPresenterDelegate
    var service: CharactersService!
    var serviceType: ServiceType!
    
    init(delegate: CharacterPresenterDelegate) {
        self.delegate = delegate
    }
    
    func searchCharacterWithName(characterName: String) {
        self.service = CharactersService(delegate: self)
        serviceType = .Search
        service.getCharacters(0, characterName: characterName)
    }
    
    func showCharacterList(offset: Int) {
        self.service = CharactersService(delegate: self)
        serviceType = .List
        service.getCharacters(offset)
    }
    
    func showCharacterDetail(characterId: Int) {
        
    }
}

extension CharacterPresenter: CharacterServiceDelegate {
    
    func onGetCharacters(characters: [Character]) {
        var charactersVO: [CharacterViewObject] = []
        var thumbnails: [Thumbnail] = []
        for character in characters {
            thumbnails.append(character.thumbnail)
            charactersVO.append(CharacterViewObject(name: character.name, thumbnail: "\(character.thumbnail.path).\(character.thumbnail.imageExtension)", characterId: character.id))
        }
        
        ImageHelper.preHeatImagesForThumbnails(thumbnails)
        
        if serviceType == .Search {
            self.delegate.onGetCharacterSearchList(charactersVO)
        } else if serviceType == .List {
            self.delegate.onGetCharacterList(charactersVO)
        }
    }
    
    func onGetCharactersError(error: NSError) {
        self.delegate.onGetCharacterListError(error.localizedDescription)
    }
}
