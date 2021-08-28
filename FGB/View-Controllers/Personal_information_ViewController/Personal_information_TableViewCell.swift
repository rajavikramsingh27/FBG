//  asfTableViewCell.swift
//  FGB
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit



class Personal_information_TableViewCell: UITableViewCell {
    @IBOutlet weak var txt_field:UITextField!
    @IBOutlet weak var lbl_title:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        set_gradient_on_label(lbl: lbl_title)
//        set_gradient_on_TF(textField: txt_field)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

