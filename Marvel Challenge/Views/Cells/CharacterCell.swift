//
//  CharacterCell.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblCharacterName: UILabel!
    
    var character: CharacterViewObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupWithCharacter(character: CharacterViewObject) {
        self.character = character
        self.imgCharacter.loadImageWithUrl(character.thumbnail, placeholder: UIImage(named: "icn-nav-marvel")!, reloadCache: false)
        self.lblCharacterName.text = character.name
    }
    
    override func didMoveToSuperview() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        gradientLayer.locations = [0.2, 1.0]
        gradientLayer.frame = self.bounds
        self.imgCharacter.layer.insertSublayer(gradientLayer, atIndex: 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
