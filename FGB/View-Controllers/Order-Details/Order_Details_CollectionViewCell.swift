//
//  Order_Details_TableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 15/04/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Order_Details_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    @IBOutlet weak var lbl_order_name:UILabel!
    @IBOutlet weak var lbl_qty:UILabel!
    @IBOutlet weak var lbl_size:UILabel!
    
    override func awakeFromNib() {
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
        
        set_gradient_on_label(lbl: lbl_order_name)
        set_gradient_on_label(lbl:lbl_qty )
        set_gradient_on_label(lbl:lbl_size )
    }
    
}
