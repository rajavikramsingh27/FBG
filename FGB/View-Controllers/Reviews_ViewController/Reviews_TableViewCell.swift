

//
//  Reviews_TableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit
import ASStarRatingView

class Reviews_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var view_Container:UIView!
    @IBOutlet weak var img_Profile:UIImageView!
    @IBOutlet weak var view_Rating:ASStarRatingView!
    
    @IBOutlet weak var lbl_Date_time:UILabel!
    @IBOutlet weak var lbl_name:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view_Container.layer.cornerRadius = 2
        view_Container.layer.shadowOpacity = 1.0
        view_Container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view_Container.layer.shadowRadius = 3.0
        view_Container.layer.shadowColor = UIColor .lightGray.cgColor
        
        img_Profile.layer.cornerRadius = img_Profile.frame.size.height/2
        img_Profile.layer.borderColor = UIColor .white .cgColor
        img_Profile.layer.borderWidth = 5
        img_Profile.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
}
