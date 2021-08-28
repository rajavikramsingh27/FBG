//
//  Country_TableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 13/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Country_TableViewCell: UITableViewCell {

    @IBOutlet weak var btn_select:UIButton!
    @IBOutlet weak var lbl_name_country:UILabel!
    
    @IBOutlet weak var img_flag:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
