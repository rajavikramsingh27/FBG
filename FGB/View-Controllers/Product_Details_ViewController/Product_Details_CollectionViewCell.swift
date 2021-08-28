//
//  Shop_Details_CollectionViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Product_Details_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    
    override func awakeFromNib() {
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
    }
    
}
