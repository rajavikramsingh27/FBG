
//  Orders_TableViewCell.swift
//  FGB

//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class Orders_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_processing:UILabel!
    @IBOutlet weak var lbl_product_name:UILabel!
    
    @IBOutlet weak var lbl_order_id:UILabel!
    @IBOutlet weak var lbl_time:UILabel!
    @IBOutlet weak var lbl_total_amt:UILabel!
    
    @IBOutlet weak var btn_more:UIButton!
    @IBOutlet weak var btn_more_1:UIButton!
    @IBOutlet weak var btn_cancel_white:UIButton!
    
    @IBOutlet weak var width_cancel_white:NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbl_processing.layer.cornerRadius = lbl_processing.frame.size.height/2
        lbl_processing.clipsToBounds = true
        
        btn_cancel_white.setTitle("cancel".localized, for: .normal)
        
        btn_cancel_white.layer.cornerRadius = 12
        btn_cancel_white.clipsToBounds = true
        
        set_gradient_on_label(lbl: lbl_product_name)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
