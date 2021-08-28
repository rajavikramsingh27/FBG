//
//  Shop_Subcateory_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 20/04/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Shop_Subcateory_ViewController: UIViewController {
   
    @IBOutlet weak var tbl_subcate:UITableView!
    @IBOutlet weak var nar_bar:UINavigationItem!
    @IBOutlet weak var img_category_icon:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        nar_bar.title = Model_Category.shared.category_name
        
        img_category_icon.layer.cornerRadius = img_category_icon.frame.size.height/2
        img_category_icon.clipsToBounds = true
        
        let u = Model_Category.shared.category_icon
        let img_name = u.components(separatedBy: k_images_url)
        
        if img_name.count > 1 {
            let img_ = img_name[1]
            if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                let u = "\(k_images_url)/\(encoded)"
                let url = URL(string:u)
                img_category_icon.sd_setImage(with:url!, placeholderImage:img_default_app)
            }
        } else {
            img_category_icon.sd_setImage(with:URL (string: u), placeholderImage:img_default_app)
        }

    }
    
    @IBAction func btn_view_all(_ sender:Any) {
        Model_Item_Details.shared.is_get_product_by_category = true
        Model_Category.shared.subcategory_code = Model_Category.shared.category_code
        Model_Category.shared.subcategory_name = Model_Category.shared.category_name
        
        func_present_items_VC()
    }

    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }

}




extension Shop_Subcateory_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Category.shared.Subcategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Shop_Subcateory_ViewCell
        
        let model = Model_Category.shared.Subcategory[indexPath.row]
        
        cell.lbl_subcate_name.text = model.subcategory_name
        
        cell.img_subcate.sd_showActivityIndicatorView()
        cell.img_subcate.sd_setIndicatorStyle(.gray)
        
        let u = model.subcategory_icon
        let img_name = u.components(separatedBy: k_images_url)
        
        if img_name.count > 1 {
            var img_ = img_name[1]
            if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                let u = "\(k_images_url)/\(encoded)"
                let url = URL(string:u)
                cell.img_subcate.sd_setImage(with:url!, placeholderImage:img_default_app)
            }
        } else {
            cell.img_subcate.sd_setImage(with:URL (string: u), placeholderImage:img_default_app)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        Model_Item_Details.shared.is_get_product_by_category = false
        let model = Model_Category.shared.Subcategory[indexPath.row]
        Model_Category.shared.subcategory_code = model.subcategory_code
        Model_Category.shared.subcategory_name = model.subcategory_name
        
        func_present_items_VC()
    }
    
    func func_present_items_VC() {
        let search_VC = storyboard?.instantiateViewController(withIdentifier: "Item_Details_ViewController") as! Item_Details_ViewController
        present(search_VC, animated: true, completion: nil)
    }
    
    
}
