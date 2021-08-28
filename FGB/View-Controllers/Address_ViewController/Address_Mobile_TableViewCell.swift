
//  Address_Mobile_TableViewCell.swift
//  FGB
//  Created by iOS-Appentus on 24/04/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class Address_Mobile_TableViewCell: UITableViewCell {
    @IBOutlet weak var txt_field:UITextField!
    @IBOutlet weak var btn_country_code:UIButton!
    @IBOutlet weak var lbl_title:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
//        set_gradient_on_TF(textField: txt_field)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
