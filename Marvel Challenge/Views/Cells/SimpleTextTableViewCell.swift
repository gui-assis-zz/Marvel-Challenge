//
//  SimpleTextTableViewCell.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 14/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class SimpleTextTableViewCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    
    func setupWithText(text: String) {
        self.lblText.text = text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
