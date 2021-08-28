//
//  ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Item_Details_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    @IBOutlet weak var img_is_sale_new_offer:UIImageView!
    @IBOutlet weak var lbl_desc:UILabel!
    @IBOutlet weak var lbl_price:UILabel!
    @IBOutlet weak var lbl_product_name:UILabel!
    
    
    override func awakeFromNib() {
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
    }
    
    
    
}



