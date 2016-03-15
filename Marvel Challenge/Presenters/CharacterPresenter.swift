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
            
            var stories: [CollectionItem] = []
            var comics: [CollectionItem] = []
            var events: [CollectionItem] = []
            var series: [CollectionItem] = []
            var urls: [UrlVO] = []
            
            for story in character.stories {
                stories.append(CollectionItem(resourceURI: story.resourceURI, name: story.name))
            }
            
            for event in character.events {
                events.append(CollectionItem(resourceURI: event.resourceURI, name: event.name))
            }
            
            for comic in character.comics {
                comics.append(CollectionItem(resourceURI: comic.resourceURI, name: comic.name))
            }
    
            for serie in character.series {
                series.append(CollectionItem(resourceURI: serie.resourceURI, name: serie.name))
            }
            
            for url in character.urls {
                urls.append(UrlVO(urlType: url.urlType, link: url.url))
            }
            
            let storyCollection = Collection(collectionType: .Stories, items: stories)
            let eventCollection = Collection(collectionType: .Events, items: events)
            let serieCollection = Collection(collectionType: .Series, items: series)
            let comicCollection = Collection(collectionType: .Comics, items: comics)
            
            charactersVO.append(CharacterViewObject(name: character.name, characterDescription: character.description, thumbnail: "\(character.thumbnail.path).\(character.thumbnail.imageExtension)", characterId: character.id, comics: comicCollection, series: serieCollection, stories: storyCollection, events: eventCollection, urls: urls))
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
