//
//  Search_Cate_CollectionViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 25/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Search_Cate_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btn_cate:UIButton!
    
    override func awakeFromNib() {
        
        btn_cate.layer.borderColor = color_gold.cgColor
        btn_cate.layer.borderWidth = 1
        btn_cate.layer.cornerRadius = 4
        btn_cate.clipsToBounds = true
    }
    
}
