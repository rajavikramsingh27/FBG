//  Search_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.

import UIKit
import WARangeSlider



class Search_ViewController: UIViewController {
    @IBOutlet weak var tbl_search:UITableView!
    
    @IBOutlet weak var coll_high_rated:UICollectionView!
    @IBOutlet weak var coll_recently_viewed:UICollectionView!
    @IBOutlet weak var coll_sale:UICollectionView!
    @IBOutlet weak var coll_searched:UICollectionView!
    @IBOutlet weak var coll_cate:UICollectionView!
    
    @IBOutlet weak var view_searched:UIView!
    @IBOutlet weak var view_search_bar:UIView!
    
    @IBOutlet weak var img_search_icon:UIImageView!
    @IBOutlet weak var btn_cross:UIButton!
    @IBOutlet weak var txt_search:UITextField!
    
    @IBOutlet weak var lbl_total_items:UILabel!
    
    @IBOutlet weak var hieght_recent_product:NSLayoutConstraint!
    @IBOutlet weak var view_container_recent:UIView!
    
    @IBOutlet weak var btn_clear_button:UIButton!
    
    @IBOutlet weak var search_title_lbl: UILabel!
    
    @IBOutlet weak var lbl_hight_rated: UILabel!
    @IBOutlet weak var lbl_recently: UILabel!
    @IBOutlet weak var lbl_sale: UILabel!
    
    var arr_cate = ["men".localized,"women".localized,"kids".localized]
    
    var arr_selected_cate = [Bool]()
    
    var activityIndicator = UIActivityIndicatorView()
    var activityIndicator_recent = UIActivityIndicatorView()
    var activityIndicator_best_seller = UIActivityIndicatorView()
    
    var page = 1
    
    var  product_collection_type = ""
    
    var arr_searched = [Model_Search]()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dict_filter["collection_type"] = ""
        btn_clear_button.setTitle("clear".localized, for: .normal)
        
        search_title_lbl.text = "search".localized
        
        lbl_hight_rated.text = "highRated".localized
        lbl_recently.text = "RecentView".localized
        lbl_sale.text = "Sale".localized
        
        view_searched.isHidden = true
        btn_clear_button.isHidden = true
        
        img_search_icon.image = UIImage (named: "search-white")
        btn_cross.isHidden = true
        
        view_search_bar.layer.cornerRadius = view_search_bar.frame.size.height/2
        view_search_bar.clipsToBounds = true
        
        for _ in arr_cate {
            arr_selected_cate.append(false)
        }
        func_get_home_product()
        func_get_recent()
        func_get_bestseller()
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_filter), name: NSNotification.Name (rawValue: "filter"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(btn_cross(_:)), name: NSNotification.Name (rawValue: "clear_filter"), object: nil)
        
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            if let collection_type = UserDefaults.standard.object(forKey: "Collection") as? String {
//                if collection_type == "men" {
//                    btn_men.backgroundColor = color_gold
//                    btn_men.setTitleColor(UIColor .white, for: .normal)
//
//                    btn_women.backgroundColor = UIColor .black
//                    btn_women.setTitleColor(color_gold, for: .normal)
//                } else {
//                    btn_women.backgroundColor = color_gold
//                    btn_women.setTitleColor(UIColor .white, for: .normal)
//
//                    btn_men.backgroundColor = UIColor .black
//                    btn_men.setTitleColor(color_gold, for: .normal)
//                }
            }
        }
        
        
        set_gradient_on_label(lbl: search_title_lbl)
        set_gradient_on_label(lbl: lbl_total_items)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lbl_total_items.isHidden = true
    }
    
    @objc func func_filter() {
        btn_clear_button.isHidden = false
        let items_found = "items found".localized
//        collection_type
        if Model_Search.shared.arr_searched.count == 0 {
            self.lbl_total_items.isHidden = false
        } else {
            self.lbl_total_items.isHidden = true
        }
        coll_searched.reloadData()
        view_searched.isHidden = false
    }
    
    func func_search() {
//        func_ShowHud()
        Model_Search.shared.func_search { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.lbl_total_items.isHidden = true
                } else {
                    self.lbl_total_items.isHidden = false
                }
                
                self.arr_searched = Model_Search.shared.arr_searched
                
                if !self.product_collection_type.isEmpty {
                    Model_Search.shared.arr_searched.removeAll()
                    
                    for model in self.arr_searched {
                        if self.product_collection_type.lowercased() ==  model.product_collection_type.lowercased() {
                            Model_Search.shared.arr_searched.append(model)
                        }
                    }
                } else {
                    self.arr_searched = Model_Search.shared.arr_searched
                }
                
                self.tbl_search.reloadData()
                self.func_filter()
            }
        }
        
    }
    
    func func_get_recent() {
        func_ShowHud_recent()
        Model_Search.shared.func_get_recent { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_recent()
                
                if Model_Search.shared.arr_get_recent.count == 0 {
                    self.hieght_recent_product.constant = 0
                    self.view_container_recent.frame = CGRect(x: 0, y: 0, width:self.view.frame.size.width, height:469)
                } else {
                    self.view_container_recent.frame = CGRect(x: 0, y: 0, width:self.view.frame.size.width, height:611)
                    self.hieght_recent_product.constant = 142
                }
                
                self.coll_recently_viewed.reloadData()
                self.tbl_search.reloadData()
            }
        }
        
    }
    
    func func_get_home_product() {
        func_ShowHud_sale()
        Model_Search.shared.func_get_home_product { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_sale()
                self.coll_sale.reloadData()
            }
        }
    }
    
    func func_get_bestseller() {
        func_ShowHud_best_seller()
        Model_Products.shared.func_get_bestseller { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_best_seller()
                self.coll_high_rated.reloadData()
            }
        }
    }
    
    func func_update_setting() {
        func_ShowHud()
        Model_setting.shared.func_update_setting { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
//                if status == "success" {
//                    self.func_ShowHud_Success(with: Model_setting.shared.str_message)
//                } else {
//                    self.func_ShowHud_Error(with: Model_setting.shared.str_message)
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
//                    self.func_HideHud()
//                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func btn_search_cate (_ sender:UIButton) {
        for i in 0..<arr_selected_cate.count {
            if i == sender.tag {
                if arr_selected_cate[i] {
                    arr_selected_cate[i] = false
                    dict_filter["collection_type"] = ""
                  
                } else {
                    arr_selected_cate[i] = true
                    dict_filter["collection_type"] = sender.title(for: .normal)
                    func_filter_prodcut()
                }
            } else {
                arr_selected_cate[i] = false
                
            }
        }
        
        for i in 0..<arr_selected_cate.count {
            if arr_selected_cate[i] {
                product_collection_type = arr_cate[i]
                break
            } else {
                product_collection_type = ""
            }
        }
        
        if !self.product_collection_type.isEmpty {
            Model_Search.shared.arr_searched.removeAll()
            
            for model in self.arr_searched {
                if product_collection_type.lowercased() ==  model.product_collection_type.lowercased() {
                    Model_Search.shared.arr_searched.append(model)
                }
            }
        } else {
            Model_Search.shared.arr_searched = self.arr_searched
        }
        
        if Model_Search.shared.arr_searched.count == 0 {
            self.lbl_total_items.isHidden = false
        } else {
            self.lbl_total_items.isHidden = true
        }
    
        
//        func_filter()
        
        coll_searched.reloadData()
        coll_cate.reloadData()
//        func_update_setting()
    }
    
    
    func func_filter_prodcut() {
        func_ShowHud()
        
        Model_filter.shared.func_filter_prodcut { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                NotificationCenter.default.post(name: NSNotification.Name (rawValue: "filter"), object: nil)
            }
        }
    }
    
    
    
    @IBAction func btn_back (_ sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_cross (_ sender:UIButton) {
        self.view.endEditing(true)
        img_search_icon.image = UIImage (named: "search-white")
        btn_cross.isHidden = true
        view_searched.isHidden = true
        txt_search.text = ""
        btn_clear_button.isHidden = true
        self.lbl_total_items.isHidden = true
        arr_selected_cate = [Bool]()
        for _ in arr_cate {
            arr_selected_cate.append(false)
        }
        self.coll_cate.reloadData()
    }
    
    @IBAction func btn_present_filter (_ sender:Any) {
        let filter_VC = storyboard?.instantiateViewController(withIdentifier: "Filter_ViewController") as! Filter_ViewController
        present(filter_VC, animated: true, completion: nil)
    }
    
    func func_set_border(object:UIButton)  {
        object.layer.cornerRadius = 4
        object.layer.borderColor = color_gold .cgColor
        object.layer.borderWidth = 1
    }
}





//  MARK:- UICollectionView methods
extension Search_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == coll_high_rated {
            return CGSize (width: 160, height: 160)
        } else if collectionView == coll_recently_viewed {
            return CGSize (width: 100, height: 100)
        } else if collectionView == coll_sale {
            return CGSize (width: 160, height: 160)
        } else if collectionView == coll_searched {
            return CGSize (width: 160, height: 290)
        } else if collectionView == coll_cate {
            return CGSize (width: 80, height: 30)
        } else {
            return CGSize (width: 160, height: 260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == coll_high_rated {
            return Model_Products.shared.arr_get_bestseller.count
        } else if collectionView == coll_recently_viewed {
            return Model_Search.shared.arr_get_recent.count
        } else if collectionView == coll_sale {
             return Model_Products.shared.arr_get_home_product.count
        } else if collectionView == coll_searched {
            return Model_Search.shared.arr_searched.count
        } else if collectionView == coll_cate {
            return arr_cate.count
        } else {
            return 10
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == coll_high_rated {
//            if indexPath.row%2 == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Products_CollectionViewCell
                
                let model = Model_Products.shared.arr_get_bestseller[indexPath.row]
                
                cell.img_spacks.sd_setShowActivityIndicatorView(true)
                cell.img_spacks.sd_setIndicatorStyle(.gray)
                
                let u = model.image_path
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
//            } else {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-1", for: indexPath)
//
//                return cell
//            }
        } else if collectionView == coll_recently_viewed {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! Recently_Viewed_CollectionViewCell
            let model = Model_Search.shared.arr_get_recent[indexPath.row]
            
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
        } else if collectionView == coll_searched {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-searched", for: indexPath) as! Search_CollectionViewCell
            
            cell.img_spacks.sd_setShowActivityIndicatorView(true)
            cell.img_spacks.sd_setIndicatorStyle(.gray)
            
            let model = Model_Search.shared.arr_searched[indexPath.row]
            
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
            
            cell.lbl_prod_name.text = model.product_name
            let full_price = Double(model.currency_price)!*Double(model.product_price)!
//            cell.lbl_prod_price.text = "\(String(format: "%.2f", full_price)) \(currency_symbol)"
            cell.lbl_prod_price.text = "\(arabic_digits("\(full_price)")) \(currency_symbol)"
            
            set_gradient_on_label(lbl: cell.lbl_prod_name)
            set_gradient_on_label(lbl: cell.lbl_prod_price)
            
            return cell
        } else if collectionView == coll_cate {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Search_Cate_CollectionViewCell
          
            cell.btn_cate.setTitle(arr_cate[indexPath.row], for: .normal)
            cell.btn_cate.tag = indexPath.row
            set_grad_to_btn(btn: cell.btn_cate)
            cell.btn_cate.addTarget(self, action: #selector(btn_search_cate(_:)), for: .touchUpInside)
            
            if arr_selected_cate[indexPath.row] {
                cell.btn_cate.backgroundColor = color_gold
                cell.btn_cate.setTitleColor(UIColor .white, for: .normal)
            } else {
                cell.btn_cate.backgroundColor = UIColor .black
                cell.btn_cate.setTitleColor(color_gold, for: .normal)
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
            let model = Model_Search.shared.arr_get_recent[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id
            
        } else if collectionView == coll_sale {
            let model = Model_Search.shared.arr_get_home_product[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id
            
        } else if collectionView == coll_high_rated {
            let model = Model_Products.shared.arr_get_bestseller[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id

        } else if collectionView == coll_searched {
            let model = Model_Search.shared.arr_searched[indexPath.row]
            
            Model_Category.shared.subcategory_code = model.subcategory_code
            Model_Products.shared.product_id = model.product_id
            
        }
        
        func_present_product_details()
    }
    
    func func_present_product_details() {
        let shop_details = storyboard?.instantiateViewController(withIdentifier: "Product_Details_ViewController") as! Product_Details_ViewController
        present(shop_details, animated: true, completion: nil)
    }
}

extension Search_ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view_searched.isHidden = false
        if textField.text!.isEmpty {
            img_search_icon.image = UIImage (named: "search-gold")
            btn_cross.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            img_search_icon.image = UIImage (named: "search-white")
            btn_cross.isHidden = true
            txt_search.text = ""
            view_searched.isHidden = true
        }
    }
    
    @IBAction func txt_Search(_ sender: UITextField) {
        Model_Search.shared.keyword = sender.text!
        func_search()
    }
    
}




extension Search_ViewController {
    
    func func_ShowHud_sale() {
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        self.activityIndicator.frame = CGRect(x: self.coll_sale.frame.size.width/2-30, y: self.coll_sale.frame.size.height/2-30, width: 60, height: 60)
        self.activityIndicator.color = UIColor .gray
        self.activityIndicator.backgroundColor = UIColor .white //.withAlphaComponent(0.7)
        self.activityIndicator.startAnimating()
        
        self.activityIndicator.layer.cornerRadius = 10
        self.activityIndicator.clipsToBounds = true
        
        self.coll_sale.addSubview(self.activityIndicator)
        self.coll_sale.isUserInteractionEnabled = false
    }
    
    func func_HideHud_sale() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.coll_sale.isUserInteractionEnabled = true
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
        
        self.view_container_recent.addSubview(self.activityIndicator_recent)
        self.view_container_recent.isUserInteractionEnabled = false
    }
    
    func func_HideHud_recent() {
        DispatchQueue.main.async {
            self.activityIndicator_recent.stopAnimating()
            self.view_container_recent.isUserInteractionEnabled = true
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

    
    
}




