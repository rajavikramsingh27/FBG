//
//  Wishlist_CollectionViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Wishlist_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    @IBOutlet weak var view_delete:UIView!
    @IBOutlet weak var btn_delete:UIButton!
    @IBOutlet weak var btn_hide_delete_view:UIButton!
    
    @IBOutlet weak var lbl_product_name:UILabel!
    @IBOutlet weak var lbl_desc:UILabel!
    @IBOutlet weak var lbl_price:UILabel!
    
    override func awakeFromNib() {
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
        
    }
    
}

