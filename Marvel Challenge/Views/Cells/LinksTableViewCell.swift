//
//  LinksTableViewCell.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 14/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit

class LinksTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLinkType: UILabel!
    var link: String!
    
    func setupWithUrlVO(urlVO: UrlVO){
        self.lblLinkType.text = urlVO.urlType.description
        self.link = urlVO.link
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
