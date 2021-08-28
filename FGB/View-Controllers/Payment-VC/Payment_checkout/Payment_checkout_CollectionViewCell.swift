//
//  Payment_checkout_CollectionViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Payment_checkout_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    @IBOutlet weak var lbl_product_name:UILabel!
    
    override func awakeFromNib() {
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
    }
    
}
