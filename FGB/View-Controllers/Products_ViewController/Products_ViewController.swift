//  Products_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.

import UIKit
import SVProgressHUD
import AVKit
import Photos


class Products_ViewController: UIViewController {
   
    @IBOutlet weak var img_new_and_hot:UIImageView!
    @IBOutlet weak var lbl_cate_first:UILabel!
    @IBOutlet weak var img_spacks:UIImageView!
    
    @IBOutlet weak var coll_group:UICollectionView!
    @IBOutlet weak var coll_high_rated:UICollectionView!
    @IBOutlet weak var coll_recently_viewed:UICollectionView!
    @IBOutlet weak var coll_sale:UICollectionView!
    
    @IBOutlet weak var tbl_products:UITableView!
    @IBOutlet weak var view_container:UIView!
    @IBOutlet weak var view_new_hot_container:UIView!
    @IBOutlet weak var hieght_coll_product_details:NSLayoutConstraint!
    
    @IBOutlet weak var new_hot_lbl: UILabel!
    @IBOutlet weak var spack_one_lbl: UILabel!
    
    @IBOutlet weak var spack_three_lbl: UILabel!
    @IBOutlet weak var spack_four_lbl: UILabel!
    @IBOutlet weak var spack_five_lbl: UILabel!

    
    var arr_group_shop = ["Spacks","Sunglasses","Accessories","Lingerie"]
    
    var activityIndicator_sale = UIActivityIndicatorView()
    var activityIndicator_recent = UIActivityIndicatorView()
    var activityIndicator_category = UIActivityIndicatorView()
    
    var activityIndicator_best_seller = UIActivityIndicatorView()
    var activityIndicator_new = UIActivityIndicatorView()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if is_from_noti {
            NotificationCenter.default.post(name:NSNotification.Name (rawValue: "cheers"), object: nil)
        }
        
        img_new_and_hot.layer.cornerRadius = 10
        img_new_and_hot.clipsToBounds = true
        
        img_spacks.layer.cornerRadius = 10
        img_spacks.clipsToBounds = true
        
        func_category_subcate()
        
        func_get_home_product()
        func_get_recent()
        func_get_bestseller()
//        func_get_new()
        gradient_all()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func_get_recent()
    }
    
    func gradient_all() {
        set_gradient_on_label(lbl: new_hot_lbl)
        set_gradient_on_label(lbl: spack_one_lbl)
        set_gradient_on_label(lbl: spack_three_lbl)
        set_gradient_on_label(lbl: spack_four_lbl)
        set_gradient_on_label(lbl: spack_five_lbl)
        
        new_hot_lbl.text = "highRated".localized
        spack_three_lbl.text = "highRated".localized
        spack_four_lbl.text = "RecentView".localized
        spack_five_lbl.text = "Sale".localized
    }
    
    func func_get_home_product() {
        func_ShowHud_sale()
        Model_Products.shared.func_get_home_product { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_sale()
                
                if status == "success" {
                    
                } else {
                    
                }
                
                if Model_Products.shared.arr_get_home_product.count == 0 {
                    
                } else {
                    
                }
                self.coll_sale.reloadData()
            }
        }
    }
    
    
    
    func func_get_recent() {
//        func_ShowHud_recent()
        Model_Products.shared.func_get_recent { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_recent()
                
                if status == "success" {
                    
                } else {
                    
                }
                
                if Model_Products.shared.arr_get_recent.count == 0 {
                    self.hieght_coll_product_details.constant = 0
                    self.view_container.frame = CGRect(x: 0, y: 0, width:self.view.frame.size.width, height:1468)
                } else {
                    self.hieght_coll_product_details.constant = 142
                    self.view_container.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height:1568)
                }
                self.coll_recently_viewed.reloadData()
                self.tbl_products.reloadData()
            }
        }
    }
    
    func func_category_subcate() {
        func_ShowHud_category()
        Model_Products.shared.func_category_subcate { (status) in
            DispatchQueue.main.async {
                if status == "success" {
                    let model = Model_Products.shared.arr_category_subcate[Model_Products.shared.arr_category_subcate.count-1]
                    self.lbl_cate_first.text = model.category_name
                    
                    self.img_spacks.sd_setShowActivityIndicatorView(true)
                    self.img_spacks.sd_setIndicatorStyle(.gray)
                    
                    let u = model.category_icon
                    let img_name = u.components(separatedBy: k_images_url)
                    if img_name.count > 1 {
                       let img_ = img_name[1]
                        if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                            let u = "\(k_images_url)/\(encoded)"
                            let url = URL(string:u)
                            self.img_spacks.sd_setImage(with:url!, placeholderImage:img_default_app)
                        }
                    } else {
                        self.img_spacks.sd_setImage(with:URL (string:u), placeholderImage:img_default_app)
                    }
                }
                self.func_HideHud_category()
                self.coll_group.reloadData()
            }
        }
    }
    
    func func_get_bestseller() {
        func_ShowHud_best_seller()
        Model_Products.shared.func_get_bestseller { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_best_seller()
                
                    if status == "success"  {
                    let model = Model_Products.shared.arr_get_bestseller[0]
                        
                    self.img_new_and_hot.sd_setShowActivityIndicatorView(true)
                    self.img_new_and_hot.sd_setIndicatorStyle(.gray)
                        
                    let u = model.image_path
                    let img_name = u.components(separatedBy: k_images_url)
                    if img_name.count > 1 {
                        let img_ = img_name[1]

                        if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                            let u = "\(k_images_url)/\(encoded)"
                            let url = URL(string:u)
                            self.img_new_and_hot.sd_setImage(with:url!, placeholderImage:img_default_app)
                        }
                    } else {
                        self.img_new_and_hot.sd_setImage(with:URL (string: u), placeholderImage:img_default_app)
                    }

                }
                
                
                self.coll_high_rated.reloadData()
            }
        }
    }
    
//    func func_get_new() {
//        func_ShowHud_new()
//        Model_Products.shared.func_get_new { (status) in
//            DispatchQueue.main.async {
//
//                if status == "success" {
//                    let model = Model_Products.shared.arr_get_new[0]
//
//                    self.img_new_and_hot.sd_setShowActivityIndicatorView(true)
//                    self.img_new_and_hot.sd_setIndicatorStyle(.gray)
//
//                    let u = model.category_icon
//                    let img_name = u.components(separatedBy: k_images_url)
//                    if img_name.count > 1 {
//                        let img_ = img_name[1]
//
//                        if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
//                            let u = "\(k_images_url)/\(encoded)"
//                            let url = URL(string:u)
//                            self.img_new_and_hot.sd_setImage(with:url!, placeholderImage:img_default_app)
//                        }
//                    } else {
//                        self.img_new_and_hot.sd_setImage(with:URL (string: u), placeholderImage:img_default_app)
//                    }
//
//                }
//
//                self.func_HideHud_new()
//            }
//        }
//    }

    
    @IBAction func btn_search(_ sender:UIButton) {
        let search_VC = storyboard?.instantiateViewController(withIdentifier: "Search_ViewController") as! Search_ViewController
        present(search_VC, animated: true, completion: nil)
    }
    
    @IBAction func btn_spacks(_ sender:UIButton) {
        if Model_Products.shared.arr_category_subcate.count > 0 {
            let model = Model_Products.shared.arr_category_subcate[Model_Products.shared.arr_category_subcate.count-1]
            Model_Category.shared.subcategory_code = model.category_code
            Model_Category.shared.subcategory_name = model.category_name
            
            Model_Item_Details.shared.arr_Subcategory = model.Subcategory
            
            Model_Item_Details.shared.is_get_product_by_category = true
            func_present_items_VC()
        }
    }
    
    @IBAction func btn_new_hot(_ sender:UIButton) {
        if Model_Products.shared.arr_get_bestseller.count > 0 {
            let model = Model_Products.shared.arr_get_bestseller[0]
            
            Model_Category.shared.subcategory_code = model.subcategory_code
            Model_Products.shared.product_id = model.product_id
            
            func_present_product_VC()
        }
    }
    
    
    
}



//  MARK:- UICollectionView methods
extension Products_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == coll_group {
            return CGSize (width: 160, height: 202)
        } else if collectionView == coll_high_rated {
            return CGSize (width: 160, height: 160)
        } else if collectionView == coll_recently_viewed {
            return CGSize (width: 100, height: 100)
        } else if collectionView == coll_sale {
            return CGSize (width: 160, height: 160)
        } else {
            return CGSize (width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == coll_group {
            if Model_Products.shared.arr_category_subcate.count > 2 {
                return 2
            } else {
                return Model_Products.shared.arr_category_subcate.count
            }
        } else if collectionView == coll_high_rated {
            return Model_Products.shared.arr_get_bestseller.count
        } else if collectionView == coll_recently_viewed {
            return Model_Products.shared.arr_get_recent.count
        } else if collectionView == coll_sale {
            return Model_Products.shared.arr_get_home_product.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == coll_group {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Products_CollectionViewCell
            
            let model = Model_Products.shared.arr_category_subcate[indexPath.row]
            cell.lbl_title.text = model.category_name
            set_gradient_on_label(lbl:  cell.lbl_title)
            
            cell.img_spacks.sd_setShowActivityIndicatorView(true)
            cell.img_spacks.sd_setIndicatorStyle(.gray)
            
            let u = model.category_icon
            let img_name = u.components(separatedBy: k_images_url)
            if img_name.count > 1 {
               let img_ = img_name[1]
                if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    let u = "\(k_images_url)/\(encoded)"
                    let url = URL(string:u)
                    cell.img_spacks.sd_setImage(with:url!, placeholderImage:img_default_app)
                }
            } else {
                cell.img_spacks.sd_setImage(with:URL (string:u), placeholderImage:img_default_app)
            }
            
            return cell
        } else if collectionView == coll_high_rated {
//            if indexPath.row%2 == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Products_CollectionViewCell
                
                let model = Model_Products.shared.arr_get_bestseller[indexPath.row]
            
                cell.img_spacks.sd_setShowActivityIndicatorView(true)
                cell.img_spacks.sd_setIndicatorStyle(.gray)
            
                let u = model.image_path
                let img_name = u.components(separatedBy: k_images_url)
                print(img_name)
                if img_name.count > 1 {
                    let img_ = img_name[1]
                    if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                        let u = "\(k_images_url)/\(encoded)"
                        let url = URL(string:u)
                        cell.img_spacks.sd_setImage(with:url!, placeholderImage:img_default_app)
                    }
                } else {
                    cell.img_spacks.sd_setImage(with:URL (string:u), placeholderImage:img_default_app)
                }
            
                return cell
//            } else {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-1", for: indexPath)
//
//                return cell
//            }
        } else if collectionView == coll_recently_viewed {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Recently_Viewed_CollectionViewCell
            let model = Model_Products.shared.arr_get_recent[indexPath.row]
            
            cell.img_spacks.sd_setShowActivityIndicatorView(true)
            cell.img_spacks.sd_setIndicatorStyle(.gray)
            
            let u = model.image_path
            let img_name = u.components(separatedBy: k_images_url)
            var img_ = ""
            if img_name.count > 1 {
                img_ = img_name[1]
                if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    let u = "\(k_images_url)/\(encoded)"
                    let url = URL(string:u)
                    cell.img_spacks.sd_setImage(with:url!, placeholderImage:img_default_app)
                }
            } else {
                cell.img_spacks.sd_setImage(with:URL (string:u), placeholderImage:img_default_app)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Products_CollectionViewCell
            
            let model = Model_Products.shared.arr_get_home_product[indexPath.row]
            
            cell.img_spacks.sd_setShowActivityIndicatorView(true)
            cell.img_spacks.sd_setIndicatorStyle(.gray)
                
            let u = model.image_path
            let img_name = u.components(separatedBy: k_images_url)
            var img_ = ""
            if img_name.count > 1 {
                img_ = img_name[1]
                
                if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    let u = "\(k_images_url)/\(encoded)"
                    let url = URL(string:u)
                    cell.img_spacks.sd_setImage(with:url!, placeholderImage:img_default_app)
                }
            } else {
                cell.img_spacks.sd_setImage(with:URL (string:u), placeholderImage:img_default_app)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == coll_recently_viewed {
            let model = Model_Products.shared.arr_get_recent[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id
            func_present_product_VC()
        } else if collectionView == coll_sale {
            let model = Model_Products.shared.arr_get_home_product[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id
            
            func_present_product_VC()
        } else if collectionView == coll_group {
            let model = Model_Products.shared.arr_category_subcate[indexPath.row]
            
            Model_Category.shared.subcategory_code = model.category_code
            Model_Category.shared.subcategory_name = model.category_name
            Model_Item_Details.shared.arr_Subcategory = model.Subcategory
            Model_Item_Details.shared.is_get_product_by_category = true
            
            func_present_items_VC()
        } else if collectionView == coll_high_rated {
            let model = Model_Products.shared.arr_get_bestseller[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id
            
            func_present_product_VC()
        }
        
    }
    
    func func_present_items_VC() {
        let search_VC = storyboard?.instantiateViewController(withIdentifier: "Item_Details_ViewController") as! Item_Details_ViewController
        present(search_VC, animated: true, completion: nil)
    }
    
    func func_present_product_VC() {
        let shop_details = storyboard?.instantiateViewController(withIdentifier: "Product_Details_ViewController") as! Product_Details_ViewController
        present(shop_details, animated: true, completion: nil)
    }
    
}

extension Products_ViewController {
    
    func func_ShowHud_sale() {
        self.activityIndicator_sale = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        self.activityIndicator_sale.frame = CGRect(x: self.coll_sale.frame.size.width/2-30, y: self.coll_sale.frame.size.height/2-30, width: 60, height: 60)
        self.activityIndicator_sale.color = UIColor .gray
        self.activityIndicator_sale.backgroundColor = UIColor .white //.withAlphaComponent(0.7)
        self.activityIndicator_sale.startAnimating()
        
        self.activityIndicator_sale.layer.cornerRadius = 10
        self.activityIndicator_sale.clipsToBounds = true
        
        self.coll_sale.addSubview(self.activityIndicator_sale)
        self.coll_sale.isUserInteractionEnabled = false
    }
    
    func func_HideHud_sale() {
        DispatchQueue.main.async {
            self.activityIndicator_sale.stopAnimating()
            self.coll_sale.isUserInteractionEnabled = true
            self.activityIndicator_sale.removeFromSuperview()
        }
    }
    
    func func_ShowHud_recent() {
        self.activityIndicator_recent = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        self.activityIndicator_recent.frame = CGRect(x: self.coll_recently_viewed.frame.size.width/2-30, y: self.coll_recently_viewed.frame.size.height/2-30, width: 60, height: 60)
        self.activityIndicator_recent.color = UIColor .gray
//        self.activityIndicator_recent.backgroundColor = UIColor .white //.withAlphaComponent(0.7)
        self.activityIndicator_recent.startAnimating()
        
        self.activityIndicator_recent.layer.cornerRadius = 10
        self.activityIndicator_recent.clipsToBounds = true
        
        self.coll_recently_viewed.addSubview(self.activityIndicator_recent)
        self.coll_recently_viewed.isUserInteractionEnabled = false
    }
    
    func func_HideHud_recent() {
        DispatchQueue.main.async {
            self.activityIndicator_recent.stopAnimating()
            self.coll_recently_viewed.isUserInteractionEnabled = true
            self.activityIndicator_recent.removeFromSuperview()
        }
    }
    
    func func_ShowHud_category() {
        self.activityIndicator_category = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        self.activityIndicator_category.frame = CGRect(x: self.coll_group.frame.size.width/2-30, y: self.coll_group.frame.size.height/2-30, width: 60, height: 60)
        self.activityIndicator_category.color = UIColor .gray
        self.activityIndicator_category.backgroundColor = UIColor .white //.withAlphaComponent(0.7)
        self.activityIndicator_category.startAnimating()
        
        self.activityIndicator_category.layer.cornerRadius = 10
        self.activityIndicator_category.clipsToBounds = true
        
        self.coll_group.addSubview(self.activityIndicator_category)
        self.coll_group.isUserInteractionEnabled = false
    }
    
    func func_HideHud_category() {
        DispatchQueue.main.async {
            self.activityIndicator_category.stopAnimating()
            self.coll_group.isUserInteractionEnabled = true
            self.activityIndicator_recent.removeFromSuperview()
        }
    }

    
    func func_ShowHud_best_seller() {
        self.activityIndicator_best_seller = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        self.activityIndicator_best_seller.frame = CGRect(x: self.coll_high_rated.frame.size.width/2-30, y: self.coll_high_rated.frame.size.height/2-30, width: 60, height: 60)
        self.activityIndicator_best_seller.color = UIColor .gray
        self.activityIndicator_best_seller.backgroundColor = UIColor .white //.withAlphaComponent(0.7)
        self.activityIndicator_best_seller.startAnimating()
        
        self.activityIndicator_best_seller.layer.cornerRadius = 10
        self.activityIndicator_best_seller.clipsToBounds = true
        
        self.coll_high_rated.addSubview(self.activityIndicator_best_seller)
        self.coll_high_rated.isUserInteractionEnabled = false
    }
    
    func func_HideHud_best_seller() {
        DispatchQueue.main.async {
            self.activityIndicator_best_seller.stopAnimating()
            self.coll_high_rated.isUserInteractionEnabled = true
            self.activityIndicator_best_seller.removeFromSuperview()
        }
    }

    
    
    func func_ShowHud_new() {
        self.activityIndicator_new = UIActivityIndicatorView(activityIndicatorStyle:.white)
        
        self.activityIndicator_new.frame = CGRect(x: self.view_new_hot_container.frame.size.width/2-30, y: self.view_new_hot_container.frame.size.height/2-30, width: 60, height: 60)
        self.activityIndicator_new.color = UIColor .gray
        self.activityIndicator_new.backgroundColor = UIColor .clear //.withAlphaComponent(0.7)
        self.activityIndicator_new.startAnimating()
        
        self.activityIndicator_new.layer.cornerRadius = 10
        self.activityIndicator_new.clipsToBounds = true
        
        self.view_new_hot_container.addSubview(self.activityIndicator_new)
        self.view_new_hot_container.isUserInteractionEnabled = false
    }
    
    func func_HideHud_new() {
        DispatchQueue.main.async {
            self.activityIndicator_new.stopAnimating()
            self.view_new_hot_container.isUserInteractionEnabled = true
            self.activityIndicator_new.removeFromSuperview()
        }
    }

    
}







