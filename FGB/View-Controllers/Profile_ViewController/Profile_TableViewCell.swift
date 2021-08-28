//
//  Profile_TableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Profile_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var img_payment_not:UIImageView!
    @IBOutlet weak var lbl_total_order:UILabel!
    
    @IBOutlet weak var lbl_wallet_amount:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbl_total_order.layer.cornerRadius = lbl_total_order.frame.size.height/2
        lbl_total_order.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



