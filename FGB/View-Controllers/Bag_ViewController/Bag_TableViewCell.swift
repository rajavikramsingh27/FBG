//
//  Bag_TableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Bag_TableViewCell: UITableViewCell {
    @IBOutlet weak var img_spacks:UIImageView!
    
    @IBOutlet weak var lbl_size:UILabel!
    @IBOutlet weak var lbl_qty:UILabel!

    @IBOutlet weak var lbl_product_name:UILabel!
    @IBOutlet weak var lbl_price:UILabel!
    @IBOutlet weak var lbl_desc:UILabel!
    
    @IBOutlet weak var btn_size:UIButton!
    @IBOutlet weak var btn_qty:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
    }
    
    
    
}
