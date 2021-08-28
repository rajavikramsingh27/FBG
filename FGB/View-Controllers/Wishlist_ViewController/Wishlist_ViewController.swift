//
//  Wishlist_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

var is_wish_list = false

class Wishlist_ViewController: UIViewController {
    @IBOutlet weak var view_wishlist:UIView!
    @IBOutlet weak var btn_start_shopping:UIButton!
    
    @IBOutlet weak var coll_recently_viewed:UICollectionView!
    @IBOutlet weak var coll_product_details:UICollectionView!
    
    @IBOutlet weak var hieght_coll_product_details:NSLayoutConstraint!
 
    @IBOutlet weak var wishlist_lbl: UILabel!
    @IBOutlet weak var recently_viewed_lbl: UILabel!
    
    @IBOutlet weak var lbl_your_wish_empty: UILabel!
    
    var page = 1
    
    var activityIndicator_recent = UIActivityIndicatorView()
    
    var arr_selected = [Bool]()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_start_shopping.layer.cornerRadius = btn_start_shopping.frame.size.height/2
        btn_start_shopping.clipsToBounds = true
        
        self.view_wishlist.isHidden = true
        set_gradient_on_label(lbl: wishlist_lbl)
        set_gradient_on_label(lbl: recently_viewed_lbl)
        set_gradient_on_label(lbl: lbl_your_wish_empty)
        
        recently_viewed_lbl.text = "RecentView".localized
        wishlist_lbl.text = "wishlist".localized
        lbl_your_wish_empty.text = "your_wishlist_is_empty".localized
        
        btn_start_shopping.setTitle("start_shopping".localized, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Model_Wishlist.shared.arr_get_wish_list.removeAll()
        Model_Wishlist.shared.page = "1"
        func_get_wish_list()
    }
    
    func func_get_wish_list() {
        func_ShowHud()
        Model_Wishlist.shared.func_get_wish_list { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    
                } else {
                    self.page = self.page-1
                }
                
                if Model_Wishlist.shared.arr_get_wish_list.count == 0 {
                    self.coll_product_details.isHidden = true
                    self.view_wishlist.isHidden = true
                } else {
                    self.coll_product_details.isHidden = false
                    self.view_wishlist.isHidden = false
                    
                }
                
                self.arr_selected.removeAll()
                for _ in 0..<Model_Wishlist.shared.arr_get_wish_list.count {
                    self.arr_selected.append(false)
                }
                
                self.coll_product_details.reloadData()
            }
        }
    }
    
    func func_remove_to_wishlist_product() {
        func_ShowHud()
        Model_Wishlist.shared.func_remove_to_wishlist_product { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    Model_Wishlist.shared.arr_get_wish_list.removeAll()
                    self.page = 1
                    Model_Wishlist.shared.page = "\(self.page)"
                    self.func_ShowHud_Success(with: Model_Wishlist.shared.str_message)
                    self.func_get_wish_list()
                } else {
                    self.func_ShowHud_Error(with: Model_Wishlist.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                })
            }
        }
    }

    func func_get_recent() {
        func_ShowHud_recent()
        Model_Products.shared.func_get_recent { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_recent()
                
                if status == "success" {
                    
                } else {
                    
                }
                
                if Model_Wishlist.shared.arr_get_recent.count == 0 {
                    self.hieght_coll_product_details.constant = 0
                } else {
                    self.hieght_coll_product_details.constant = 100
                }
                self.coll_recently_viewed.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btn_delete (_ sender:UIButton) {
        func_remove_to_wishlist_product()
    }
    
    @IBAction func btn_start_shopping(_ sender:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "start_shopping"), object: nil)
    }
    
    @IBAction func btn_hide_delete_view (_ sender:UIButton) {
        for i in 0..<Model_Wishlist.shared.arr_get_wish_list.count {
            if i == sender.tag {
                arr_selected[i] = false
            } else {
                arr_selected[i] = false
            }
        }
        coll_product_details.reloadData()
    }
    
    @IBAction func btn_present_filter (_ sender:Any) {
        let filter_VC = storyboard?.instantiateViewController(withIdentifier: "Filter_ViewController") as! Filter_ViewController
        present(filter_VC, animated: true, completion: nil)
    }

}




//  MARK:- UICollectionView methods
extension Wishlist_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == coll_recently_viewed {
            return CGSize (width: 100, height: 100)
        } else if collectionView == coll_product_details {
              return CGSize (width: collectionView.frame.size.width/2-10, height: 350)
        } else {
            return CGSize (width: 160, height: 260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == coll_recently_viewed {
            return Model_Products.shared.arr_get_recent.count
        } else if collectionView == coll_product_details {
            return Model_Wishlist.shared.arr_get_wish_list.count
        } else {
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == coll_recently_viewed {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Recently_Viewed_CollectionViewCell
            let model = Model_Products.shared.arr_get_recent[indexPath.row]
            
            cell.img_spacks.sd_setShowActivityIndicatorView(true)
            cell.img_spacks.sd_setIndicatorStyle(.gray)
//            cell.img_spacks.sd_setImage(with:URL (string: model.product_image), placeholderImage:(UIImage(named:"Mask Group -14.png")))
            
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
        } else if collectionView == coll_product_details {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-1", for: indexPath) as! Wishlist_CollectionViewCell
            
            let model = Model_Wishlist.shared.arr_get_wish_list[indexPath.row]
            
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
            cell.lbl_product_name.text = model.product_name
            cell.lbl_desc.text = model.product_description
            let full_price = Double(model.currency_price)!*Double(model.product_price)!
//            cell.lbl_price.text = "\((String(format: "%.2f", full_price))) \(currency_symbol)"
            cell.lbl_price.text = "\(arabic_digits("\(full_price)")) \(currency_symbol)"
            
            if arr_selected[indexPath.row] {
                cell.view_delete.isHidden = false
            } else {
                cell.view_delete.isHidden = true
            }
            
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(btn_delete(_:)), for: .touchUpInside)
            
            cell.btn_hide_delete_view.tag = indexPath.row
            cell.btn_hide_delete_view.addTarget(self, action: #selector(btn_hide_delete_view(_:)), for: .touchUpInside)
            
            let longPressRecognizer = UILongPressGestureRecognizer (target: self, action: #selector(longPressed(sender:)))
            longPressRecognizer.minimumPressDuration = 1
            cell.addGestureRecognizer(longPressRecognizer)
            
            
            set_gradient_on_label(lbl: cell.lbl_product_name)
            set_gradient_on_label(lbl: cell.lbl_desc)
            set_gradient_on_label(lbl: cell.lbl_price)
            
            
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)// as! Search_CollectionViewCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == coll_recently_viewed {
            let model = Model_Products.shared.arr_get_recent[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id
        } else {
            let model = Model_Wishlist.shared.arr_get_wish_list[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id
        }
        
        let shop_details = storyboard?.instantiateViewController(withIdentifier: "Product_Details_ViewController") as! Product_Details_ViewController
        present(shop_details, animated: true, completion: nil)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        
        if coll_product_details == scrollView {
            if ((coll_product_details.contentOffset.y + coll_product_details.frame.size.height) >= scrollView.contentSize.height) {
                page = page+1
                Model_Wishlist.shared.page = "\(page)"
                func_get_wish_list()
            }
        }
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
            let touchPoint = sender.location(in:coll_product_details)
            if let indexPath = coll_product_details.indexPathForItem(at: touchPoint) {
                
                for i in 0..<Model_Wishlist.shared.arr_get_wish_list.count {
                    if i == indexPath.row {
                        arr_selected[i] = true
                        Model_Wishlist.shared.product_id = Model_Wishlist.shared.arr_get_wish_list[i].product_id
                    } else {
                        arr_selected[i] = false
                    }
                }
                coll_product_details.reloadData()
            }
        }
    
}


extension Wishlist_ViewController {
    func func_ShowHud_recent() {
        self.activityIndicator_recent = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        self.activityIndicator_recent.frame = CGRect(x: self.coll_recently_viewed.frame.size.width/2-30, y: self.coll_recently_viewed.frame.size.height/2-30, width: 60, height: 60)
        self.activityIndicator_recent.color = UIColor .gray
        self.activityIndicator_recent.backgroundColor = UIColor .white //.withAlphaComponent(0.7)
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
        }
    }

}

