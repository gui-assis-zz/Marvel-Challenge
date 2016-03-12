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
}

class CharacterPresenter: NSObject {
    
    var delegate: CharacterPresenterDelegate
    var service: CharactersService!
    
    init(delegate: CharacterPresenterDelegate) {
        self.delegate = delegate
    }
    
    func showCharacterList() {
        self.service = CharactersService(delegate: self)
        service.getCharacters()
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
        self.delegate.onGetCharacterList(charactersVO)
    }
    
    func onGetCharactersError(error: NSError) {
        self.delegate.onGetCharacterListError(error.localizedDescription)
    }
}
