//
//  Shipping_TableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 26/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Shipping_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_delivery_type:UILabel!
    @IBOutlet weak var lbl_delivery_type_cost:UILabel!
    @IBOutlet weak var lbl_delivery_days:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
