


//
//  asdfViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit



class Payment_methods_list_Next_TableViewCell: UITableViewCell {
    @IBOutlet weak var btn_edit:UIButton!
    @IBOutlet weak var btn_delete:UIButton!
    @IBOutlet weak var lbl_card_value:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btn_edit.layer.cornerRadius = btn_edit.frame.size.height/2
        btn_edit.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

