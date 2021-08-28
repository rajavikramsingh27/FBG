



//
//  Category_CollectionViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 12/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Category_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view_container:UIView!
    @IBOutlet weak var lbl_sub_cate_name:UILabel!
    @IBOutlet weak var img_sub_cate:UIImageView!
    
    
    
    override func awakeFromNib() {
        view_container.layer.cornerRadius = 4
        view_container.clipsToBounds = true
    }
    
    
    
}
