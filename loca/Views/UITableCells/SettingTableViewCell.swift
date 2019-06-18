//
//  SettingTableViewCell.swift
//  loca
//
//  Created by Dalton Nguyen on 6/18/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(image : UIImage, description : String){
        imageIcon.image = image
        descriptionLabel.text = description
    }

}
