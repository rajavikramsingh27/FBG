//
//  Start_CollectionViewCell.swift
//  FGB

//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class Walk_Through_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btn_start:UIButton!
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var img_WT:UIImageView!
    @IBOutlet weak var hight_start_button:NSLayoutConstraint!
//    @IBOutlet weak var hight_title_label:NSLayoutConstraint!
//    @IBOutlet weak var desc_lbl: UILabel!
    
    override func awakeFromNib() {
        set_gradient_on_label(lbl: lbl_title)
        btn_start.setTitle("start".localized, for: .normal)
        
        btn_start.layer.cornerRadius = btn_start.frame.size.height/2
        btn_start.clipsToBounds = true
        
        self.layer.shadowOpacity = 10.0
        self.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = UIColor .red.cgColor
    }
    
}
