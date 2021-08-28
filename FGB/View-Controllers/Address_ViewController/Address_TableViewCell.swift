//  aadfaffaTableViewCell.swift
//  FGB
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class Address_TableViewCell: UITableViewCell {
    @IBOutlet weak var txt_field:UITextField!
    @IBOutlet weak var img_flag:UIImageView!
    @IBOutlet weak var lbl_Title:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        set_gradient_on_label(lbl: lbl_Title)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

