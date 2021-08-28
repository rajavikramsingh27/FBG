//
//  Wallet_TableViewCell.swift
//  FGB
//
//  Created by appentus on 6/28/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Wallet_TableViewCell: UITableViewCell {
    @IBOutlet weak var img_product:UIImageView!
    
    @IBOutlet weak var lbl_product_name:UILabel!
    @IBOutlet weak var lbl_order_id:UILabel!
    @IBOutlet weak var lbl_quantity:UILabel!
    @IBOutlet weak var lbl_price:UILabel!
    @IBOutlet weak var lbl_date:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img_product.layer.cornerRadius = 10
        img_product.clipsToBounds = true
        
        set_gradient_on_label(lbl:lbl_product_name)
        set_gradient_on_label(lbl:lbl_order_id)
        set_gradient_on_label(lbl:lbl_quantity)
        set_gradient_on_label(lbl:lbl_price)
        set_gradient_on_label(lbl:lbl_date)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
