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
    var thumbnail: Thumbnail?
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
        
        self.thumbnail = Thumbnail(json: json["thumbnail"])
        
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
}
