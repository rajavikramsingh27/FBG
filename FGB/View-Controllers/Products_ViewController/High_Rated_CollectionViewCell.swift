//
//  ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit


class High_Rated_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    @IBOutlet weak var img_spacks_1:UIImageView!
    @IBOutlet weak var img_spacks_2:UIImageView!
    @IBOutlet weak var img_spacks_3:UIImageView!
    
    override func awakeFromNib() {
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
        
        img_spacks_1.layer.cornerRadius = 10
        img_spacks_1.clipsToBounds = true

        img_spacks_2.layer.cornerRadius = 10
        img_spacks_2.clipsToBounds = true
        
        img_spacks_3.layer.cornerRadius = 10
        img_spacks_3.clipsToBounds = true
    }
}
