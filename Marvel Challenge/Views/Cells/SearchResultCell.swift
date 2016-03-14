//
//  SearchResultCell.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var lblCharacterName: UILabel!
    @IBOutlet weak var imgCharacter: UIImageView!
    
    var character: CharacterViewObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupWithCharacter(character: CharacterViewObject) {
        self.character = character
        self.imgCharacter.loadImageWithUrl(character.thumbnail, placeholder: nil, reloadCache: false)
        self.lblCharacterName.text = character.name
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
