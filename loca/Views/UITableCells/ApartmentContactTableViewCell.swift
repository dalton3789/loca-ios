//
//  ApartmentContactTableViewCell.swift
//  loca
//
//  Created by Toan Nguyen on 6/1/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class ApartmentContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(name : String, phone : String) {
        lbl_name.text = name
        lbl_phone.text = phone
    }

}
