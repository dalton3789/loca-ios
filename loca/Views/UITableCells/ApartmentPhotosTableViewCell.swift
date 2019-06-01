//
//  ApartmentPhotosTableViewCell.swift
//  loca
//
//  Created by Toan Nguyen on 6/1/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit

class ApartmentPhotosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img_photos: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(image : UIImage){
        img_photos.image = image
    }

}
