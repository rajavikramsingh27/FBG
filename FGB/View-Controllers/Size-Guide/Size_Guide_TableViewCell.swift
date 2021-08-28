//
//  Size_Guide_TableViewCell.swift
//  FGB
//
//  Created by appentus on 6/20/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Size_Guide_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_uk:UILabel!
    @IBOutlet weak var lbl_eu:UILabel!
    @IBOutlet weak var lbl_us:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        set_gradient_on_label(lbl: lbl_uk)
        set_gradient_on_label(lbl: lbl_eu)
        set_gradient_on_label(lbl: lbl_us)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
