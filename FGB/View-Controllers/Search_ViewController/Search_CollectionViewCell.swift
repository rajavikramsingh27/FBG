//
//  ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Search_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    @IBOutlet weak var lbl_prod_name:UILabel!
    @IBOutlet weak var lbl_prod_price:UILabel!
    
    override func awakeFromNib() {
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
    }
    
}
