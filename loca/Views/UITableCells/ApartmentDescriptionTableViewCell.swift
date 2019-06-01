//
//  ApartmentDescriptionTableViewCell.swift
//  loca
//
//  Created by Toan Nguyen on 6/1/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class ApartmentDescriptionTableViewCell: UITableViewCell {
    
    
  
    @IBOutlet weak var txt_description: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(description : String) {
        txt_description.text = description
    }

}
