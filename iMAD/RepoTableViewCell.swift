//
//  RepoTableViewCell.swift
//  iMAD
//
//  Created by hendi on 13/03/17.
//  Copyright © 2017 cuca. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var nStarsLabel: UILabel!
    @IBOutlet weak var nForksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
