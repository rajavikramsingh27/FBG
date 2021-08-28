//
//  asdfadfadfTableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit


class Settigns_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_title_right:UILabel!
    
    @IBOutlet weak var img_flag:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
