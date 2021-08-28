


//
//  ASDViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Payment_methods_list_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_payment_type:UILabel!
    @IBOutlet weak var lbl_card_number:UILabel!
    @IBOutlet weak var lbl_default_peyment:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbl_card_number.layer.cornerRadius = lbl_card_number.frame.size.height/2
        lbl_card_number.layer.borderColor = color_gold .cgColor
        lbl_card_number.layer.borderWidth = 1
        lbl_card_number.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

