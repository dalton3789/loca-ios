//
//  ApartmentBasicTableViewCell.swift
//  loca
//
//  Created by Toan Nguyen on 6/1/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class ApartmentBasicTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var img_icon: UIImageView!
    @IBOutlet weak var lbl_description: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(image: UIImage, description : String) {
        
        lbl_description.text = description
        img_icon.image = image
    }

}
