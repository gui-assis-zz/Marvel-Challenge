//
//  CharacterViewObject.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

enum CollectionType: String {
    case Comics = "Comics"
    case Series = "Series"
    case Stories = "Stories"
    case Events = "Events"
}

class CharacterViewObject: NSObject {
    var name: String
    var characterDescription: String
    var thumbnail: String
    var characterId: Int
    var comics: Collection
    var series: Collection
    var stories: Collection
    var events: Collection
    var urls: [UrlVO]
    
    init(name: String, characterDescription: String, thumbnail: String, characterId: Int, comics: Collection, series: Collection, stories: Collection, events: Collection, urls: [UrlVO]) {
        self.name = name
        self.characterDescription = characterDescription
        self.thumbnail = thumbnail
        self.characterId = characterId
        
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
}