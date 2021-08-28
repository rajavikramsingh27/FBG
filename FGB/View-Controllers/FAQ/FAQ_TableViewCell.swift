//
//  FAQ_TableViewCell.swift
//  FGB
//
//  Created by appentus on 6/21/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class FAQ_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_faq_title:UILabel!
    @IBOutlet weak var lbl_faq_ans:UILabel!
    @IBOutlet weak var btn_up_down:UIButton!
    @IBOutlet weak var btn_select:UIButton!
    
    @IBOutlet weak var height_faq_ans:NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
