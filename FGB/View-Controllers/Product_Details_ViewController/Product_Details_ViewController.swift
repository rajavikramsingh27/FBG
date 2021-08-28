//  Product_Details_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit

class Product_Details_ViewController: UIViewController {
    @IBOutlet weak var btn_add_To_bag:UIButton!
//    @IBOutlet weak var btn_reviews:UIButton!
    @IBOutlet weak var view_details:UIView!
    
    @IBOutlet weak var coll_first:UICollectionView!
    @IBOutlet weak var coll_second:UICollectionView!
    
    @IBOutlet weak var lbl_size:UILabel!
    @IBOutlet weak var view_img_down:UIView!
    
    @IBOutlet weak var page_controll:UIPageControl!
    @IBOutlet weak var btn_heart:UIButton!
    
    @IBOutlet weak var view_picker_container:UIView!
    @IBOutlet weak var picker_view:UIPickerView!
    
    @IBOutlet weak var lbl_prod_name:UILabel!
    @IBOutlet weak var lbl_prod_desc:UILabel!
    @IBOutlet weak var lbl_prod_price:UILabel!
    
    @IBOutlet weak var lbl_material:UILabel!
    @IBOutlet weak var lbl_season:UILabel!
    @IBOutlet weak var lbl_delivery_time:UILabel!
    @IBOutlet weak var lbl_origin:UILabel!
    @IBOutlet weak var lbl_washing:UILabel!
    
    @IBOutlet weak var lbl_out_of_stock:UILabel!
    
//    @IBOutlet weak var view_shipping_address: UIView!
//    @IBOutlet weak var tbl_shippging:UITableView!
    @IBOutlet weak var tbl_product:UITableView!
//    @IBOutlet weak var lbl_shipping_address:UILabel!
    
//    @IBOutlet weak var view_size: UIView!
//    @IBOutlet weak var scroll_view_size: UIScrollView!
//    @IBOutlet weak var img_size: UIImageView!
    
    @IBOutlet weak var view_product: UIView!
    
    @IBOutlet weak var lbl_materials: UILabel!
    @IBOutlet weak var lbl_seasons: UILabel!
    @IBOutlet weak var lbl_deliveries: UILabel!
    @IBOutlet weak var lbl_origins: UILabel!
    @IBOutlet weak var lbl_washings: UILabel!
    @IBOutlet weak var you_might_like_lbl: UILabel!
    
    @IBOutlet weak var size_guide_btn: UIButton!
//    @IBOutlet weak var shipping_btn: UIButton!
    @IBOutlet weak var abount_btn: UIButton!
    @IBOutlet weak var btn_done: UIButton!
    
    var is_wishlist_down = false
    
    var arr_picker = [String]()
    var activityIndicator_related_prods = UIActivityIndicatorView()
    
    var selected_size = "0"
    var delegate: reload_bag!

    var size_guide_VC = Size_Guide_ViewController()
    var about_VC = About_ViewController()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_add_To_bag.setTitle("addtobag".localized, for: .normal)
        btn_add_To_bag.setTitle("gotobag".localized, for: .selected)
        
        size_guide_btn.setTitle("size_guide".localized, for: .normal)
        abount_btn.setTitle("about_only".localized, for: .normal)
        you_might_like_lbl.text = "you_might_like".localized
        lbl_out_of_stock.text = "currently this product is out of stock".localized
        
        btn_done.setTitle("done".localized, for: .normal)
        
        lbl_out_of_stock.isHidden = true
        
        page_controll.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        btn_heart.layer.cornerRadius = btn_heart.frame.size.height/2
        btn_heart.clipsToBounds = true
        
//        lbl_size.layer.cornerRadius = btn_add_To_bag.frame.size.height/2
        lbl_size.layer.borderColor = hexStringToUIColor(hex:"FCF578") .cgColor
        lbl_size.layer.borderWidth = 1
        lbl_size.clipsToBounds = true
        
        view_img_down.layer.borderColor = hexStringToUIColor(hex:"FCF578").cgColor
        view_img_down.layer.borderWidth = 1
        view_img_down.clipsToBounds = true
        
        btn_add_To_bag.layer.cornerRadius = btn_add_To_bag.frame.size.height/2
        btn_add_To_bag.clipsToBounds = true
        
//        btn_reviews.layer.cornerRadius = btn_reviews.frame.size.height/2
//        btn_reviews.clipsToBounds = true
        
        view_details.layer.cornerRadius = 10
        view_details.clipsToBounds = true
        
        view_picker_container.isHidden = true
        view_picker_container.layer.cornerRadius = 10
        view_picker_container.clipsToBounds = true
        
        func_Set_Design()
        func_get_product_details()
        func_get_wish_list()
        
//        view_shipping_address.isHidden = true
//        view_size.isHidden = true
//        scroll_view_size.delegate = self
//        scroll_view_size.minimumZoomScale = 1.0
//        scroll_view_size.maximumZoomScale = 10.0
        set_gradiet_on_views()
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_size_guide), name: NSNotification.Name (rawValue: "size_guide"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(func_about), name: NSNotification.Name (rawValue: "product_about"), object: nil)
    }
    
    @objc func func_size_guide() {
        size_guide_VC.view.removeFromSuperview()
    }
    
    @objc func func_about() {
        about_VC.view.removeFromSuperview()
    }
    
    func set_gradiet_on_views(){
        
        set_gradient_on_label(lbl: lbl_size)
        set_gradient_on_label(lbl: lbl_prod_name)
        set_gradient_on_label(lbl: lbl_prod_desc)
        set_gradient_on_label(lbl: lbl_prod_price)
//        set_gradient_on_label(lbl: lbl_material)
//        set_gradient_on_label(lbl: lbl_season)
//        set_gradient_on_label(lbl: lbl_delivery_time)
//        set_gradient_on_label(lbl: lbl_origin)
//        set_gradient_on_label(lbl: lbl_washing)
//        set_gradient_on_label(lbl: lbl_shipping_address)
//        set_gradient_on_label(lbl: lbl_materials)
//        set_gradient_on_label(lbl: lbl_seasons)
//        set_gradient_on_label(lbl: lbl_deliveries)
//        set_gradient_on_label(lbl: lbl_origins)
//        set_gradient_on_label(lbl: lbl_washings)
        set_gradient_on_label(lbl: you_might_like_lbl)
        
        set_grad_to_btn(btn: btn_heart)
//        set_grad_to_btn(btn: btn_reviews)
        set_grad_to_btn(btn: size_guide_btn)
        set_grad_to_btn(btn: abount_btn)
//        set_grad_to_btn(btn: shipping_btn)

    }
    
    
    func func_Set_Design() {
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: coll_first.frame.size.width, height: coll_first.frame.height)
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets (top: 0, left: 30, bottom: 0, right: 30)
        coll_first.collectionViewLayout = layout
        
        let layout_TripFunds = UPCarouselFlowLayout()
        layout_TripFunds.itemSize = CGSize(width: coll_second.frame.size.width, height: coll_second.frame.height)
        layout_TripFunds.scrollDirection = .horizontal
        coll_second.collectionViewLayout = layout_TripFunds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func func_get_product_details() {
        DispatchQueue.main.async {
            self.func_ShowHud()
        }
        
        Model_Product_details.shared.func_get_product_details { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.lbl_prod_name.text = Model_Product_details.shared.product_name
                    self.lbl_prod_desc.text = Model_Product_details.shared.product_description
                    let full_price = Double(Model_Product_details.shared.currency_price)!*Double(Model_Product_details.shared.product_price)!
//                    self.lbl_prod_price.text = "\(String(format: "%.2f", full_price)) \(currency_symbol)"
                    
                    self.lbl_prod_price.text = "\(self.arabic_digits("\(full_price)")) \(currency_symbol)"
                    
                    self.lbl_material.text = Model_Product_details.shared.product_material
                    self.lbl_season.text = Model_Product_details.shared.product_season
                    self.lbl_delivery_time.text = Model_Product_details.shared.delivery_days
                    
                    self.lbl_origin.text = Model_Product_details.shared.poduct_origin
                    self.lbl_washing.text = Model_Product_details.shared.product_is_washing
                    
                    Model_Size_Guize.shared.size_guide_id = Model_Product_details.shared.product_size_guide_id
                    
                    self.arr_picker = Model_Product_details.shared.product_sizes.components(separatedBy: ",")
                    self.lbl_size.text = self.arr_picker[0]
                    Model_Product_details.shared.product_size = self.arr_picker[0]
                    self.picker_view.reloadAllComponents()
                    
//                    if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
//                        let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
//                        print(dict_LoginData)
//                    }
                    
                    if Model_Product_details.shared.inwishlist == "0" {
                        self.btn_heart.isSelected = false
                    } else {
                        self.btn_heart.isSelected = true
                    }
                    
                    if Model_Product_details.shared.related_products.count == 0 {
                        self.view_product.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: 1270)
                    } else {
                        self.view_product.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: 1850)
                    }
                    
                    self.page_controll.numberOfPages = Model_Product_details.shared.product_images.count
                    self.coll_first.reloadData()
                    self.coll_second.reloadData()
                    self.tbl_product.reloadData()
                } else {
                    
                }
            }
        }
    }
    
    func func_add_to_wishlist() {
        func_ShowHud()
        Model_Product_details.shared.func_add_to_wishlist { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Product_details.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Product_details.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                    
                    if self.is_wishlist_down {
                        self.func_get_wish_list()
                    } else {
                        self.btn_heart.isSelected = true
                    }
                })
            }
        }
        
    }
    
    func func_remove_to_wishlist_product() {
        func_ShowHud()
        Model_Product_details.shared.func_remove_to_wishlist_product { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Product_details.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Product_details.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                    if self.is_wishlist_down {
                        self.func_get_wish_list()
                    } else {
                        self.btn_heart.isSelected = false
                    }
                })
            }
        }
    }
    
    func func_add_to_cart() {
        func_ShowHud()
        Model_Product_details.shared.func_add_to_cart { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    NotificationCenter.default.post(name: NSNotification.Name (rawValue: "Bag_count"), object: nil)
                    self.func_ShowHud_Success(with: Model_Product_details.shared.str_message)
                    self.btn_add_To_bag.isSelected = true
                } else {
                    self.func_ShowHud_Error(with: Model_Product_details.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()

                })
            }
        }
        
    }
    
    func func_update_cart() {
        func_ShowHud()
        Model_Product_details.shared.func_update_cart { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Product_details.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Product_details.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                })
            }
        }
        
    }

    
    
    func func_remove_to_cart() {
        func_ShowHud()
        Model_Product_details.shared.func_remove_to_cart { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Product_details.shared.str_message)
                    self.btn_add_To_bag.isSelected = false
                } else {
                    self.func_ShowHud_Error(with: Model_Product_details.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                })
            }
        }
    }

    
    
    func func_add_recently() {
        Model_Product_details.shared.func_add_recently { (status) in
            DispatchQueue.main.async {
//                self.func_HideHud()
//                if status == "success" {
//                    self.func_ShowHud_Success(with: Model_Product_details.shared.str_message)
//                    self.btn_heart.isSelected = true
//                } else {
//                    self.func_ShowHud_Error(with: Model_Product_details.shared.str_message)
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
//                    self.func_HideHud()
//                })
            }
        }
        
    }
    
    func func_get_wish_list() {
        func_ShowHud_related_prods()
        Model_Product_details.shared.func_get_wish_list { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_related_prods()
                self.coll_second.reloadData()
            }
        }
    }
    
    func func_get_customer_address() {
        func_ShowHud()
        Model_Address.shared.func_get_customer_address { (status) in
            DispatchQueue.main.async {
                if status == "success" {
//                    self.lbl_shipping_address.text = "\(Model_Address.shared.customer_country) \(Model_Address.shared.customer_address) \(Model_Address.shared.customer_city) \(Model_Address.shared.customer_postcode)"
//                    self.tbl_shippging.reloadData()
                }
                self.func_HideHud()
            }
        }
    }
    
    @IBAction func btn_reviews(_ sender:Any) {
        let review_VC = storyboard?.instantiateViewController(withIdentifier: "Reviews_ViewController") as! Reviews_ViewController
        present(review_VC, animated: true, completion: nil)
    }
    
    @IBAction func btn_heart_down(_ sender:UIButton) {
        is_wishlist_down = true
        
        let model = Model_Product_details.shared.related_products[sender.tag]
        Model_Product_details.shared.product_id = model.product_id
        
        if sender.isSelected {
            func_remove_to_wishlist_product()
        } else {
            func_add_to_wishlist()
        }
        
    }
    
    
    @IBAction func btn_hide_shippgin_address(_ sender:UIButton) {
//        view_shipping_address.isHidden = true
    }
    
    @IBAction func btn_shippgin_address(_ sender:UIButton) {
//        view_shipping_address.isHidden = false
        
        func_get_customer_address()
    }
    
    @IBAction func btn_heart(_ sender:UIButton) {
        is_wish_list = true
        is_wishlist_down = false
        if sender.isSelected {
            func_remove_to_wishlist_product()
        } else {
            func_add_to_wishlist()
        }
        
    }
    
    @IBAction func btn_bag(_ sender:UIButton) {
        if Int64(Model_Product_details.shared.product_qty)! > Int64(0) {
            if sender.isSelected {
                if is_from_cate {
                    presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                } else {
                    
                    dismiss(animated: true, completion: nil)
                }
                is_from_cate = false
                NotificationCenter.default.post(name: NSNotification.Name (rawValue: "Go_to_Bag"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("checkout"), object: nil)
            } else {
                func_add_to_cart()
            }
        } else {
            lbl_out_of_stock.isHidden = false
        }

    }
    
    @IBAction func btn_size(_ sender:Any) {
        view_picker_container.isHidden = false
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
}



//  MARK:- UICollectionView methods
extension Product_Details_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == coll_first {
            return CGSize (width: collectionView.frame.size.width-70, height: 400)
        } else {
            return CGSize (width: collectionView.frame.size.width, height: 580)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == coll_first {
            return Model_Product_details.shared.product_images.count
        } else {
            return Model_Product_details.shared.related_products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == coll_first {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Products_CollectionViewCell
            let model = Model_Product_details.shared.product_images[indexPath.row]
            
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Related_Products_CollectionViewCell
            let model = Model_Product_details.shared.related_products[indexPath.row]
            
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
            
            cell.lbl_prod_desc.text = model.product_description
            cell.lbl_prod_name.text = model.product_name
            
            let full_price = Double(model.currency_price)!*Double(model.product_price)!
//            cell.lbl_prod_price.text = "\(String(format: "%.2f", full_price)) \(currency_symbol)"
//            cell.lbl_prod_price.text = "\(String(format: "%.2f", full_price)) \(currency_symbol)"
            self.lbl_prod_price.text = "\(self.arabic_digits("\(full_price)")) \(currency_symbol)"
            
            cell.btn_heart_down.tag = indexPath.row
            cell.btn_heart_down.addTarget(self, action: #selector(btn_heart_down(_:)), for: .touchUpInside)
            
            cell.btn_heart_down.isSelected = false
            
            for model_wishlist in Model_Product_details.shared.arr_get_wish_list {
                print(model.product_id)
                print(model_wishlist.product_id)
                
                if model.product_id == model_wishlist.product_id {
                    cell.btn_heart_down.isSelected = true
                    break
                } else {
                    cell.btn_heart_down.isSelected = false
                }
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == coll_second {
            let model = Model_Product_details.shared.related_products[indexPath.row]
            
            Model_Products.shared.category_code = model.category_code
            Model_Products.shared.product_id = model.product_id
            
            func_present_product_VC()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == coll_first {
            return UIEdgeInsets (top: 0, left: 30, bottom: 0, right: 30)
        }
        return UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = coll_first.frame.size.width-70
        page_controll.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
    }
    
    func func_present_product_VC() {
        let shop_details = storyboard?.instantiateViewController(withIdentifier: "Product_Details_ViewController") as! Product_Details_ViewController
        present(shop_details, animated: true, completion: nil)
    }

}



extension Product_Details_ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr_picker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr_picker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Model_Product_details.shared.product_size = arr_picker[row]
        lbl_size.text = arr_picker[row]
        
        if lbl_size.text == selected_size {
            self.btn_add_To_bag.isSelected = true
        } else {
            self.btn_add_To_bag.isSelected = false
        }
        
//        tbl_shippging.reloadData()
    }
    
    @IBAction func btn_size_guide(_ sender:UIButton) {
        self.size_guide_VC = self.storyboard?.instantiateViewController(withIdentifier: "Size_Guide_ViewController") as! Size_Guide_ViewController
        self.view.addSubview(self.size_guide_VC.view)
        self.addChildViewController(self.size_guide_VC)
    }
    
    @IBAction func btn_about(_ sender:UIButton) {
        about_VC = self.storyboard?.instantiateViewController(withIdentifier: "About_ViewController") as! About_ViewController
        self.view.addSubview(about_VC.view)
        self.addChildViewController(about_VC)
    }
    
    @IBAction func btn_done_scrollview(_ sender:UIButton) {
//        view_size.isHidden = true
    }
    
    @IBAction func btn_done_picker(_ sender:UIButton) {
        view_picker_container.isHidden = true
        
//        if btn_add_To_bag.isSelected {
//            func_update_cart()
//        }
    }
    
    
    func func_ShowHud_related_prods() {
        self.activityIndicator_related_prods = UIActivityIndicatorView(activityIndicatorStyle:.gray)
        
        self.activityIndicator_related_prods.frame = CGRect(x: self.coll_second.frame.size.width/2-30, y: self.coll_second.frame.size.height/2-30, width: 60, height: 60)
        self.activityIndicator_related_prods.color = UIColor .gray
        self.activityIndicator_related_prods.backgroundColor = UIColor .white //.withAlphaComponent(0.7)
        self.activityIndicator_related_prods.startAnimating()
        
        self.activityIndicator_related_prods.layer.cornerRadius = 10
        self.activityIndicator_related_prods.clipsToBounds = true
        
        self.coll_second.addSubview(self.activityIndicator_related_prods)
        self.coll_second.isUserInteractionEnabled = false
    }
    
    func func_HideHud_related_prods() {
        DispatchQueue.main.async {
            self.activityIndicator_related_prods.stopAnimating()
            self.coll_second.isUserInteractionEnabled = true
            self.activityIndicator_related_prods.removeFromSuperview()
        }
    }


}



extension Product_Details_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Product_details.shared.arr_delivery_type.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Shipping_TableViewCell
        
        let model = Model_Product_details.shared.arr_delivery_type[indexPath.row]
        
        cell.lbl_delivery_type.text = model.delivery_type
        cell.lbl_delivery_type_cost.text = model.delivery_type_cost
        cell.lbl_delivery_days.text = "\(model.product_description) \(model.delivery_days)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return img_size
//    }
//
}





