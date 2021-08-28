//
//  Category_TableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 12/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Category_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_cate_name:UILabel!
    @IBOutlet weak var btn_plus:UIButton!
    @IBOutlet weak var coll_subcategory:UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
