//
//  Character.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import SwiftyJSON

class Character: ResponseObjectSerializable {
    
    var id: Int
    var name: String
    var description: String
    var modified: String
    var thumbnail: Thumbnail
    var resourceURI: String
    var comics: [Comic] = []
    var series: [Serie] = []
    var stories: [Story] = []
    var events: [Event] = []
    var urls: [Url] = []
    
    required init?(json: JSON) {
        self.id = json[""].intValue
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.modified = json["modified"].stringValue
        self.resourceURI = json["resourceURI"].stringValue
        
        self.thumbnail = Thumbnail(json: json["thumbnail"])!
        
        for (_, subJson):(String, JSON) in json["comics"]["items"] {
            self.comics.append(Comic(json: subJson)!)
        }
        
        for (_, subJson):(String, JSON) in json["series"]["items"] {
            self.series.append(Serie(json: subJson)!)
        }
        
        for (_, subJson):(String, JSON) in json["stories"]["items"] {
            self.stories.append(Story(json: subJson)!)
        }
        
        for (_, subJson):(String, JSON) in json["events"]["items"] {
            self.events.append(Event(json: subJson)!)
        }
        
        for (_, subJson):(String, JSON) in json["urls"] {
            self.urls.append(Url(json: subJson)!)
        }
    }
    
    func printDescription() {
        print("********************** \(self.name) **********************")
        print("Description: \(self.description)")
        print("Modified: \(self.modified)")
        print("Thumbnail Path: \(self.thumbnail.path)")
        print("Thumbnail Extension: \(self.thumbnail.imageExtension)")
        print("Resource URI: \(self.resourceURI)")
        
        print("Comics: \(self.comics.count)")
        for comic in self.comics {
            print("Name: \(comic.name)")
        }
        
        print("Series: \(self.series.count)")
        for serie in self.series {
            print(" - Name: \(serie.name)")
        }
        
        print("Stories: \(self.stories.count)")
        for story in self.stories {
            print(" - Name: \(story.name)")
        }
        
        print("Events: \(self.events.count)")
        for event in self.events {
            print(" - Name: \(event.name)")
        }
        
        print("URLS: ")
        for url in self.urls {
            print(" - \(url.url)")
        }
        
        print("**********************************************************\n\n")
    }
}
