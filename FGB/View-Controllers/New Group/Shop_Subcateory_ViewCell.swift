






//
//  ShoTableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 20/04/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Shop_Subcateory_ViewCell: UITableViewCell {
    @IBOutlet weak var lbl_subcate_name:UILabel!
    @IBOutlet weak var img_subcate:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img_subcate.layer.cornerRadius = img_subcate.frame.size.height/2
        img_subcate.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
