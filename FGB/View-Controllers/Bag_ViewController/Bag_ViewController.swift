//
//  Bag_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.

protocol reload_bag {
    func func_reload_Bag()
}


import UIKit
var is_bag = false

class Bag_ViewController: UIViewController,reload_bag {
    @IBOutlet weak var btn_checkout:UIButton!
    @IBOutlet weak var btn_start_shopping:UIButton!
    @IBOutlet weak var view_picker_container:UIView!
    @IBOutlet weak var picker_view:UIPickerView!
    
    @IBOutlet weak var tbl_bag:UITableView!
    @IBOutlet weak var view_bag_list:UIView!
    
    @IBOutlet weak var lbl_total_price:UILabel!
    @IBOutlet weak var lbl_total_items:UILabel!
    @IBOutlet weak var bag_title_lbl: UILabel!
    
    @IBOutlet weak var lbl_bag_empty:UILabel!
    
    var arr_picker = [String]()
    
    var arr_qty = [String]()
    var arr_size = [String]()
    
    var is_size = false
    
    var index_selected = -1
    
    var str_out_of_stock = ""
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_bag_empty.text = "your_bag_is_empty".localized
        
        btn_checkout.setTitle("checkout".localized, for: .normal)
        
        btn_start_shopping.layer.cornerRadius = btn_start_shopping.frame.size.height/2
        btn_start_shopping.clipsToBounds = true
        
        btn_checkout.layer.cornerRadius = btn_checkout.frame.size.height/2
        btn_checkout.clipsToBounds = true
        
        view_picker_container.isHidden = true
        view_picker_container.layer.cornerRadius = 10
        view_picker_container.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.func_view_cart), name: Notification.Name("checkout"), object: nil)

         set_grad()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        func_view_cart()
    }
    

    
    func set_grad() {
        set_gradient_on_label(lbl: lbl_total_price)
        set_gradient_on_label(lbl: lbl_total_items)
        set_gradient_on_label(lbl: bag_title_lbl)
        
        bag_title_lbl.text = "".localized
        bag_title_lbl.text = "".localized
        bag_title_lbl.text = "".localized
        
        bag_title_lbl.text = "bag".localized
        btn_start_shopping.setTitle("start_shopping".localized, for: .normal)
    }
    
    func func_reload_Bag() {
        func_view_cart()
    }
    
    @objc func func_view_cart() {
        func_ShowHud()
        Model_Bag.shared.func_view_cart { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if Model_Bag.shared.arr_view_cart.count == 0 {
                    self.view_bag_list.isHidden = true
                } else {
                    self.view_bag_list.isHidden = false
                }
                
                if Model_Bag.shared.arr_view_cart.count > 0 {
                    for i in 0..<Model_Bag.shared.arr_view_cart.count {
                        let model = Model_Bag.shared.arr_view_cart[i]
                        if Int64(model.cart_product_qty)! > Int64(model.product_qty)! || Int64(model.product_qty)! == 0 {
                            if i == 0 {
                                self.str_out_of_stock = model.cart_id
                            } else {
                                self.str_out_of_stock = "\(self.str_out_of_stock),\(model.cart_id)"
                            }
                        } else {
                            
                        }
                    }
                }
                
                if !self.str_out_of_stock.isEmpty {
                    self.func_check_out_of_stock()
                } else {
                    var total_price = 0.0
                    for i in 0..<Model_Bag.shared.arr_view_cart.count {
                        let model = Model_Bag.shared.arr_view_cart[i]
                        
                        if !model.product_price.isEmpty {
                            let full_price = Double(model.currency_price)!*Double(model.product_price)!
                            total_price = total_price+Double(String(format: "%.2f", full_price))!*Double(model.cart_product_qty)!
                            total_price = Double(String(format: "%.2f", total_price))!
                        }
                        let in_total = "intotal".localized
//                        self.lbl_total_price.text = "\(total_price) \(currency_symbol) \(in_total)"
                        self.lbl_total_price.text = "\(self.arabic_digits("\(total_price)")) \(currency_symbol) \(in_total)"
                    }
                    
                    let items = "items".localized
//                    self.lbl_total_items.text = "\(Model_Bag.shared.arr_view_cart.count) \(items)"
                    self.lbl_total_items.text = "\(self.arabic_digits("\(Model_Bag.shared.arr_view_cart.count)")) \(items)"
                    
                    DispatchQueue.main.async {
                        self.tbl_bag.reloadData()
                    }
                }
            }
        }
    }
    
    func func_remove_to_cart() {
        func_ShowHud()
        Model_Bag.shared.func_remove_to_cart { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.str_out_of_stock = ""
                    NotificationCenter.default.post(name: NSNotification.Name (rawValue: "Bag_count"), object: nil)
                    self.func_ShowHud_Success(with: Model_Bag.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Bag.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                    self.func_HideHud()
                    self.func_view_cart()
                })
            }
        }
    }
    
    func func_check_out_of_stock() {
        Model_Bag.shared.cart_id = str_out_of_stock
        func_remove_to_cart()
        
//        if arr_out_of_stock.count == 0 {
//            func_view_cart()
//        } else {
//            Model_Bag.shared.product_id = arr_out_of_stock[0]
//            func_ShowHud()
//            func_out_of_stock { (status) in
//                DispatchQueue.main.async {
//                    self.func_HideHud()
//                }
//            }
//        }
    }
    
//    func func_out_of_stock(completionHandler:@escaping (String)->()) {
//        func_ShowHud()
//        Model_Bag.shared.func_remove_to_cart { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//                self.func_check_out_of_stock()
//                completionHandler(status)
//            }
//        }
//    }
    
    
    func func_update_cart() {
        func_ShowHud()
        Model_Bag.shared.func_update_cart { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Bag.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Bag.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                    self.func_view_cart()
                })
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_start_shopping(_ sender:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "start_shopping"), object: nil)
    }
    
    @IBAction func btn_checkout(_ sender:UIButton) {
        is_from_order = false
        
        let payment_checkout = storyboard?.instantiateViewController(withIdentifier: "Payment_checkout_ViewController") as! Payment_checkout_ViewController
        present(payment_checkout, animated: true, completion: nil)
    }
    
    @IBAction func btn_present_filter (_ sender:Any) {
        let filter_VC = storyboard?.instantiateViewController(withIdentifier: "Filter_ViewController") as! Filter_ViewController
        present(filter_VC, animated: true, completion: nil)
    }

}


extension Bag_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Bag.shared.arr_view_cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Bag_TableViewCell
        
        cell.btn_qty.tag = indexPath.row
        cell.btn_size.tag = indexPath.row
        
        cell.btn_size.addTarget(self, action: #selector(btn_size(_:)), for: .touchUpInside)
        cell.btn_qty.addTarget(self, action: #selector(btn_qty(_:)), for: .touchUpInside)
        
        let model = Model_Bag.shared.arr_view_cart[indexPath.row]
        
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
            cell.img_spacks.sd_setImage(with:URL (string: u), placeholderImage:img_default_app)
        }
        
        let full_price = Double(model.currency_price)!*Double(model.product_price)!
//        cell.lbl_price.text = "\(String(format: "%.2f", full_price)) \(currency_symbol)"
        cell.lbl_price.text = "\(arabic_digits("\(full_price)")) \(currency_symbol)"
        
        cell.lbl_desc.text = "\(model.product_description)"
        cell.lbl_product_name.text = "\(model.product_name)"
        
        let sizetext = "sizetext".localized
        let qty_1 = "qty_1".localized
        
        cell.lbl_qty.text = "\(qty_1): \(model.cart_product_qty)"
        cell.lbl_size.text = "\(sizetext): \(model.cart_product_size)"
        
        set_gradient_on_label(lbl: cell.lbl_size)
        set_gradient_on_label(lbl: cell.lbl_qty)
        set_gradient_on_label(lbl: cell.lbl_product_name)
        set_gradient_on_label(lbl: cell.lbl_desc)
        set_gradient_on_label(lbl: cell.lbl_price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = Model_Bag.shared.arr_view_cart[indexPath.row]
            Model_Bag.shared.cart_id = model.cart_id
            func_remove_to_cart()
        }
    }
    
    
    @IBAction func btn_size(_ sender:UIButton) {
        index_selected = sender.tag
        
        is_size = true
        
        let model = Model_Bag.shared.arr_view_cart[sender.tag]
        Model_Bag.shared.cart_id = model.cart_id
        Model_Bag.shared.cart_product_qty = model.cart_product_qty
        Model_Bag.shared.product_id = model.product_id
        
        arr_picker = model.product_sizes.components(separatedBy: ",")
        
        picker_view.reloadAllComponents()
        view_picker_container.isHidden = false
    }
    
    @IBAction func btn_qty(_ sender:UIButton) {
        index_selected = sender.tag
        
        is_size = false
        
        let model = Model_Bag.shared.arr_view_cart[sender.tag]
        Model_Bag.shared.cart_id = model.cart_id
        Model_Bag.shared.cart_product_size = model.cart_product_size
        Model_Bag.shared.product_id = model.product_id
        
        let qty = Int(model.product_qty)
        
        var arr_picker_1 = [String]()
        for i in 0..<qty! {
            arr_picker_1.append("\(i+1)")
        }
        
        arr_picker = arr_picker_1
        
        picker_view.reloadAllComponents()
        view_picker_container.isHidden = false
    }
    
    @IBAction func btn_done_picker(_ sender:UIButton) {
        view_picker_container.isHidden = true
        func_update_cart()
    }
    
    
}




extension Bag_ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
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
        if is_size {
            Model_Bag.shared.arr_view_cart[index_selected].cart_product_size = arr_picker[row]
            Model_Bag.shared.cart_product_size = arr_picker[row]
        } else {
           Model_Bag.shared.arr_view_cart[index_selected].cart_product_qty = arr_picker[row]
           Model_Bag.shared.cart_product_qty = arr_picker[row]
        }
        tbl_bag.reloadData()
    }
    
}




