//
//  ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Item_Details_Cate_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bnt_cate:UIButton!
    
    override func awakeFromNib() {
        bnt_cate.layer.cornerRadius = bnt_cate.frame.size.height/2
        bnt_cate.clipsToBounds = true
    }
    
}
