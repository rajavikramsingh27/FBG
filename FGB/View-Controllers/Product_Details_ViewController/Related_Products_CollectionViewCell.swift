//
//  Related_Products_CollectionViewCell.swift
//  FGB
//  Created by iOS-Appentus on 18/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class Related_Products_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    
    @IBOutlet weak var lbl_prod_name:UILabel!
    @IBOutlet weak var lbl_prod_desc:UILabel!
    @IBOutlet weak var lbl_prod_price:UILabel!
    
    @IBOutlet weak var btn_heart_down:UIButton!
    
    override func awakeFromNib() {
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
        
        btn_heart_down.layer.cornerRadius = btn_heart_down.frame.size.height/2
        btn_heart_down.clipsToBounds = true
        
        set_gradient_on_label(lbl: lbl_prod_name)
        set_gradient_on_label(lbl: lbl_prod_desc)
        set_gradient_on_label(lbl: lbl_prod_price)
    }
    
}
