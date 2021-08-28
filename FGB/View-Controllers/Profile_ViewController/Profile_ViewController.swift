//
//  Profile_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit
import SDWebImage



class Profile_ViewController: UIViewController {
    @IBOutlet weak var img_user:UIImageView!
    @IBOutlet weak var lbl_user_name:UILabel!
    
    @IBOutlet weak var tbl_profile:UITableView!
    
    @IBOutlet weak var hieght_recent_product:NSLayoutConstraint!
    @IBOutlet weak var view_container_recent:UIView!
    @IBOutlet weak var coll_recent:UICollectionView!
    
    @IBOutlet weak var recently_viewed_lbl: UILabel!
    
    var activityIndicator_recent = UIActivityIndicatorView()
    
    var arr_titles = ["mywallet".localized,"order".localized,"PersonalInfo".localized,"address".localized,"help".localized,"signout".localized]
    
    var arr_total_order = [String]()
    
    var customer_wallet = ""
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        is_checkout = false
        
        img_user.layer.cornerRadius = img_user.frame.size.height/2
        img_user.clipsToBounds = true
//        Do any additional setup after loading the view.
        set_gradient_on_label(lbl: recently_viewed_lbl)
        set_gradient_on_label(lbl: lbl_user_name)
        
        recently_viewed_lbl.text = "RecentView".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func_get_recent()
        func_order_list()
        func_view_card()
        arr_total_order = [String]()
        
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            img_user.sd_setShowActivityIndicatorView(true)
            img_user.sd_setIndicatorStyle(.white)
            customer_wallet = "\(dict_LoginData["customer_wallet"]!)"
            
            let str_customer_profile = "\(dict_LoginData["customer_profile"]!)"
            let u = str_customer_profile
            let img_name = u.components(separatedBy: k_images_url)
            if img_name.count > 1 {
                let img_ = img_name[1]
                if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    let u = "\(k_images_url)/\(encoded)"
                    let url = URL(string:u)
                    img_user.sd_setImage(with:url!, placeholderImage:img_default_app)
                }
            } else {
                img_user.sd_setImage(with:URL (string:str_customer_profile), placeholderImage:img_default_app)
            }
            
            let hello = "Hello".localized
            lbl_user_name.text = "\(hello), \(dict_LoginData["customer_fname"]!)!"
//            UserDefaults.standard.set("\(dict_LoginData["customer_currency"]!)", forKey: "Currency")
            UserDefaults.standard.set("\(dict_LoginData["sizes_type"]!)", forKey: "Sizes")
            UserDefaults.standard.set("\(dict_LoginData["collection_type"]!)", forKey: "Collection")
        }
    }
    
    func func_present_About_Terms_Cond_VC() {
        str_About_Terms_Cond = "help".localized
        
        let alert = UIAlertController (title:"help".localized, message: "", preferredStyle: .actionSheet)
        let action_1 = UIAlertAction(title: "faq".localized, style: .default) { (action) in
            let faq = self.storyboard?.instantiateViewController(withIdentifier: "Faq_ViewController") as! Faq_ViewController
            self.present(faq, animated: true, completion: nil)
        }
        alert.addAction(action_1)
        
        let action_2 = UIAlertAction(title: "deliveryreturn".localized, style: .default) { (action) in
            str_help_selected = delivery_return
            str_title = "deliveryreturn".localized
            self.func_help()
        }
        
        alert.addAction(action_2)
        let action_3 = UIAlertAction(title: "tnc".localized, style: .default) { (action) in
            str_help_selected = termN_conditions
            str_title = "tnc".localized
            self.func_help()
        }
        
        alert.addAction(action_3)
        let action_4 = UIAlertAction(title: "ordertrack".localized, style: .default) { (action) in
                str_help_selected = order_track
            str_title = "ordertrack".localized
            self.func_help()
        }
        alert.addAction(action_4)
        
        let action_5 = UIAlertAction(title: "updateinfo".localized, style: .default) { (action) in
            str_help_selected = update_info
            str_title = "updateinfo".localized
            self.func_help()
        }
        alert.addAction(action_5)
        let action_6 = UIAlertAction(title: "howtoorder".localized, style: .default) { (action) in
            str_help_selected = how_to_order
            str_title = "howtoorder".localized
            self.func_help()
        }
        alert.addAction(action_6)
        
        let action_7 = UIAlertAction(title: "returnrefund".localized, style: .default) { (action) in
            str_title = "returnrefund".localized
            self.func_help()
        }
        
        alert.addAction(action_7)
        let action_8 = UIAlertAction(title: "paymentppromotion".localized, style: .default) { (action) in
            str_help_selected = payment_n_promotion
            str_title = "paymentppromotion".localized
            self.func_help()
        }
        
        alert.addAction(action_8)
        let action_9 = UIAlertAction(title: "privacysecurity".localized, style: .default) { (action) in
            str_help_selected = privacy_n_policy
            str_title = "privacysecurity".localized
            self.func_help()
        }
        alert.addAction(action_9)
        let action_10 = UIAlertAction(title: "shippinganddelivery".localized, style: .default) { (action) in
            str_help_selected = shipping_n_delivery
            str_title = "shippinganddelivery".localized
            self.func_help()
        }
        alert.addAction(action_10)
        let action_11 = UIAlertAction(title: "about".localized, style: .default) { (action) in
            str_help_selected = about_help
            str_title = "about".localized
            self.func_help()
        }
        alert.addAction(action_11)
        
        let action_12 = UIAlertAction(title: "contactus".localized, style: .default) { (action) in
            str_help_selected = contact_us
            str_title = "contactus".localized
            self.func_help()
        }
        alert.addAction(action_12)
        
        let action_13 = UIAlertAction(title: "cancel".localized, style: .cancel) { (action) in
            
        }
        alert.addAction(action_13)
        
        present(alert, animated: true, completion: nil)
    }
    
    func func_help() {
        let help_VC = storyboard?.instantiateViewController(withIdentifier: "Help_ViewController") as! Help_ViewController
        present(help_VC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func func_get_recent() {
//        func_ShowHud_recent()
        Model_profile.shared.func_get_recent { (status) in
            DispatchQueue.main.async {
                self.func_HideHud_recent()
                
                if Model_profile.shared.arr_get_recent.count == 0 {
                    self.hieght_recent_product.constant = 0
                    self.view_container_recent.frame = CGRect(x: 0, y: 0, width:self.view.frame.size.width, height:100)
                } else {
                    self.view_container_recent.frame = CGRect(x: 0, y: 0, width:self.view.frame.size.width, height:170)
                    self.hieght_recent_product.constant = 124
                }
                
                self.coll_recent.reloadData()
                self.tbl_profile.reloadData()
            }
        }
    }
    
    func func_order_list() {
//        func_ShowHud()
        Model_Order.shared.arr_order_list.removeAll()
        Model_Order.shared.func_order_list { (status) in
            DispatchQueue.main.async {
                self.tbl_profile.reloadData()
                self.func_HideHud()
            }
        }
    }
    
    
    
    func func_view_card() {
//        func_ShowHud()
        Model_payment_methods.shared.func_view_card { (status) in
            DispatchQueue.main.async {
                self.tbl_profile.reloadData()
                self.func_HideHud()
            }
        }
    }
    
    @IBAction func btn_settigns(_ sender:Any) {
        let settigns_VC = storyboard?.instantiateViewController(withIdentifier: "Settings_ViewController") as! Settings_ViewController
        present(settigns_VC, animated: true, completion: nil)
    }
    
}



//  MARK:- UICollectionView methods
extension Profile_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return Model_profile.shared.arr_get_recent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Recently_Viewed_CollectionViewCell
        
        let model = Model_profile.shared.arr_get_recent[indexPath.row]
        
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
            img_user.sd_setImage(with:URL (string:u), placeholderImage:img_default_app)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = Model_profile.shared.arr_get_recent[indexPath.row]
        
        Model_Products.shared.category_code = model.category_code
        Model_Products.shared.product_id = model.product_id
        
        let shop_details = storyboard?.instantiateViewController(withIdentifier: "Product_Details_ViewController") as! Product_Details_ViewController
        present(shop_details, animated: true, completion: nil)
    }
    
}



extension Profile_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Profile_TableViewCell
        
        let points = "points".localized
        cell.lbl_title.text = arr_titles[indexPath.row]
        if indexPath.row == 0 {
            cell.lbl_wallet_amount.isHidden = false
            cell.lbl_total_order.isHidden = true
            cell.img_payment_not.isHidden = true
            
            if customer_wallet.isEmpty {
                cell.lbl_wallet_amount.text = "0.0 \(points)"
            } else {
                str_total_points = "\(Double(customer_wallet)!)"
                cell.lbl_wallet_amount.text = "\(Double(customer_wallet)!) \(points)"
            }
        } else if indexPath.row == 1 {
            cell.img_payment_not.isHidden = true
            cell.lbl_wallet_amount.isHidden = true
            cell.lbl_total_order.text = Model_Order.shared.count
            
            if Model_Order.shared.count == "0" {
                cell.lbl_total_order.isHidden = true
            } else {
                cell.lbl_total_order.isHidden = false
            }
        } else if indexPath.row == 4 {
            cell.lbl_total_order.isHidden = true
            cell.lbl_wallet_amount.isHidden = true
            
            if Model_payment_methods.shared.arr_view_card.count == 0 {
                cell.img_payment_not.isHidden = true
            } else {
                cell.img_payment_not.isHidden = true
            }
        } else {
            cell.lbl_total_order.isHidden = true
            cell.img_payment_not.isHidden = true
            cell.lbl_wallet_amount.isHidden = true
        }
        
        set_gradient_on_label(lbl: cell.lbl_title)
        set_gradient_on_label(lbl: cell.lbl_wallet_amount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let personal_info_VC = self.storyboard?.instantiateViewController(withIdentifier: "Wallet_ViewController") as! Wallet_ViewController
            self.present(personal_info_VC, animated: true, completion: nil)
        } else if indexPath.row == 1 {
           func_present_order_VC()
        } else if indexPath.row == 2 {
            let personal_info_VC = self.storyboard?.instantiateViewController(withIdentifier: "Personal_information_ViewController") as! Personal_information_ViewController
            self.present(personal_info_VC, animated: true, completion: nil)
        } else if indexPath.row == 3 {
            let address_VC = self.storyboard?.instantiateViewController(withIdentifier: "Address_ViewController") as! Address_ViewController
            self.present(address_VC, animated: true, completion: nil)
        } else if indexPath.row == 4 {
            is_checkout = false
            func_present_About_Terms_Cond_VC()
        } else if indexPath.row == 5 {
            func_action_logout()
        }
    }
    
//    func func_action() {
//        let alert_action = UIAlertController (title: "", message: "", preferredStyle: .actionSheet)
//
//        let help =  UIAlertAction (title: "help".localized, style: .default) { (ac) in
//
//        }
//
//        let where_IS = UIAlertAction (title: "Where is my order ?", style: .default) { (ac) in
//            self.func_present_order_VC()
//        }
//
//        let how_to_return = UIAlertAction (title: "How to return my order ?", style: .default, handler: nil)
//        let how_i_cancel = UIAlertAction (title: "How i cancel my order ?", style: .default, handler: nil)
//        let cancel = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
//
//        alert_action.addAction(help)
//        alert_action.addAction(where_IS)
//        alert_action.addAction(how_to_return)
//        alert_action.addAction(how_i_cancel)
//        alert_action.addAction(cancel)
//
//        present(alert_action, animated: true, completion: nil)
//    }
    
    func func_action_logout() {
        let alert_action = UIAlertController (title: "", message: "sure".localized, preferredStyle: .alert)
        
        let help =  UIAlertAction (title: "yes".localized, style: .default) { (ac) in
            NotificationCenter.default.post(name: NSNotification.Name (rawValue: "sign_out"), object: nil)
            UserDefaults.standard.removeObject(forKey: "login_Data")
            UserDefaults.standard.removeObject(forKey: "filter")
            
            let login_VC = self.storyboard?.instantiateViewController(withIdentifier: "Login_ViewController")
            self.present(login_VC!, animated: true, completion: nil)
        }
        
        let where_IS = UIAlertAction (title: "no".localized, style: .default, handler: nil)
        
        alert_action.addAction(where_IS)
        alert_action.addAction(help)
        
        present(alert_action, animated: true, completion: nil)
    }
    
    func func_present_order_VC() {
        let orders_VC = self.storyboard?.instantiateViewController(withIdentifier: "Orders_ViewController") as! Orders_ViewController
        self.present(orders_VC, animated: true, completion: nil)
    }
    
    func func_ShowHud_recent() {
        self.activityIndicator_recent = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        self.activityIndicator_recent.frame = CGRect(x: self.view_container_recent.frame.size.width/2-30, y: self.view_container_recent.frame.size.height/2-30, width: 60, height: 60)
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

}



extension Profile_ViewController {
    
    @IBAction func btn_instagram(_ sender:UIButton) {
        let urlWhats = "https://www.instagram.com/fgb_ksa/"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install ")
                    func_present_socialt_VC()
                }
            }
        }
    }
    
    @IBAction func btn_facebook(_ sender:UIButton) {
        let urlWhats = "https://m.facebook.com/fgbksa/"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install ")
                    func_present_socialt_VC()
                }
            }
        }
    }
    
    @IBAction func btn_twitter(_ sender:UIButton) {
        let urlWhats = "https://mobile.twitter.com/FGB_KSA"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install ")
                    func_present_socialt_VC()
                }
            }
        }
    }
    
    @IBAction func btn_whatsup(_ sender:UIButton) {
        let urlWhats = "whatsapp://send?phone=+966544296665"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                    let whatsappURL = URL(string: "https://itunes.apple.com/in/app/whatsapp-messenger/id310633997?mt=8")
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL!)
                    }
                    
                }
            }
        }
        
    }
    
    
    
    @IBAction func btn_pinterest(_ sender:UIButton) {
        let urlWhats = "https://www.pinterest.com/fgb9477/"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install ")
                    func_present_socialt_VC()
                }
            }
        }
    }
    
    func func_present_socialt_VC() {
        let social_VC = storyboard?.instantiateViewController(withIdentifier: "Social_ViewController") as! Social_ViewController
        present(social_VC, animated: true, completion: nil)
    }
}
