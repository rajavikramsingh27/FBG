
//  Payment_checkout_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
//import PayPalPayment
//import PayPalFuturePayment
//import PayPalProfileSharing



var str_payment_type = "Select payment type"
var is_checkout = false
var currency_symbol = "1"
var currency_price = "1"
var currency_idd = ""



class Payment_checkout_ViewController: UIViewController {
    @IBOutlet weak var nav_bar:UINavigationItem!
    
    @IBOutlet weak var btn_change_mybag:UIButton!
    @IBOutlet weak var btn_change_delviery_add:UIButton!
//    @IBOutlet weak var btn_change_delivery_options:UIButton!
    @IBOutlet weak var btn_continue:UIButton!
    
    @IBOutlet weak var btn_delivery_free:UIButton!
    @IBOutlet weak var btn_delivery_express:UIButton!
    
    @IBOutlet weak var lbl_my_bag:UILabel!
    @IBOutlet weak var lbl_total_items:UILabel!
    
    @IBOutlet weak var lbl_full_name:UILabel!
    @IBOutlet weak var lbl_address_1:UILabel!
    @IBOutlet weak var lbl_address_2:UILabel!
    @IBOutlet weak var lbl_town_city:UILabel!
    
    @IBOutlet weak var lbl_state:UILabel!
    @IBOutlet weak var lbl_country:UILabel!
    @IBOutlet weak var lbl_postcode:UILabel!
    @IBOutlet weak var lbl_mobile_number:UILabel!
    
    @IBOutlet weak var lbl_delivery_instruction:UILabel!
    @IBOutlet weak var view_delivery_instrutction:UIView!
    @IBOutlet weak var height_delivery_instrutction:NSLayoutConstraint!
    @IBOutlet weak var height_express_delivery:NSLayoutConstraint!
    
    @IBOutlet weak var lbl_customer_wallet:UILabel!
    
    @IBOutlet weak var top_customer_wallet:NSLayoutConstraint!
    @IBOutlet weak var height_customer_wallet:NSLayoutConstraint!
    @IBOutlet weak var view_customer_wallet:UIView!
    
    @IBOutlet weak var top_discount:NSLayoutConstraint!
    @IBOutlet weak var height_discount:NSLayoutConstraint!
    @IBOutlet weak var view_discount:UIView!
    
    @IBOutlet weak var lbl_discount:UILabel!
    @IBOutlet weak var lbl_discount_value:UILabel!
    
    @IBOutlet weak var height_pay_container:NSLayoutConstraint!
    
    @IBOutlet weak var lbl_subtotal:UILabel!
    @IBOutlet weak var lbl_delivery_charge:UILabel!
    @IBOutlet weak var lbl_total_to_pay:UILabel!
    
    @IBOutlet weak var lbl_free:UILabel!
    @IBOutlet weak var lbl_standard_delivery:UILabel!
    @IBOutlet weak var lbl_delivered_on_before:UILabel!
    
    @IBOutlet weak var lbl_free_1:UILabel!
    @IBOutlet weak var lbl_standard_delivery_1:UILabel!
    @IBOutlet weak var lbl_delivered_on_before_1:UILabel!
    
    @IBOutlet weak var lbl_tax_name:UILabel!
    @IBOutlet weak var lbl_taxt_value:UILabel!
    
    @IBOutlet weak var view_std_delivery:UIView!
    @IBOutlet weak var view_exp_delivery:UIView!
    
    @IBOutlet weak var hieght_delivery_option:NSLayoutConstraint!
    @IBOutlet weak var hieght_exp_delivery:NSLayoutConstraint!
    @IBOutlet weak var hieght_std_delivery:NSLayoutConstraint!
    
    @IBOutlet weak var view_container:UIView!
    @IBOutlet weak var view_express_delivery:UIView!
    @IBOutlet weak var tbl_payment:UITableView!
    
    @IBOutlet weak var lbl_coupon:UILabel!
    
    @IBOutlet weak var txt_coupon:UITextField!
    
    @IBOutlet weak var btn_use_walllet:UIButton!
    @IBOutlet weak var lbl_delivery_address:UILabel!
    @IBOutlet weak var lbl_delivery_instruction_title:UILabel!
    
    @IBOutlet weak var lbl_delivery_options:UILabel!
    @IBOutlet weak var lbl_we_accept:UILabel!
    
    @IBOutlet weak var lbl_sub_total_title:UILabel!
    @IBOutlet weak var lbl_delivery:UILabel!
    @IBOutlet weak var lbl_total_to_pay_title:UILabel!
    @IBOutlet weak var btn_apply:UIButton!
    
    var total_price = 0.0
    var delivery_type_cost = ""
    var shipping_cost = "0"
    
    var str_delivery_address = ""
    var str_delivery_type_id = ""
    
    var tax_calculation = 0.0
    
    var full_amt = 0.0
    var discount_promo = 0.0
    
    var is_promocode = false
    var is_wallet = false
    var delegate: reload_bag!

    var delivery_charge = 0.0
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        is_checkout = true
        
        nav_bar.title = "Payment".localized
        
        txt_coupon.placeholder = "apply_coupon".localized
        
        btn_change_mybag.setTitle("change".localized, for: .normal)
        btn_change_delviery_add.setTitle("change".localized, for: .normal)
        lbl_my_bag.text = "mybag".localized
        lbl_delivery_address.text = "deveryaddress".localized
        lbl_delivery_instruction_title.text = "delinstruction".localized
        lbl_delivery_options.text = "deliveryoption".localized
        lbl_we_accept.text = "deliveryoption".localized
        
        txt_coupon.attributedPlaceholder = NSAttributedString(string:txt_coupon.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : hexStringToUIColor(hex: "CFC25D")])
        
        func_set_corner_radius(object: btn_change_mybag)
        func_set_corner_radius(object: btn_change_delviery_add)
        func_set_corner_radius(object: btn_continue)
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_order_placed), name: NSNotification.Name (rawValue: "payment_success"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(func_save_address), name: NSNotification.Name (rawValue: "save_address"), object: nil)
        
//        lbl_delivery_charge.text = "free".localized
        btn_delivery_free.isSelected = true
        btn_delivery_express.isSelected = false
        
        set_grad()
        func_get_delivery_type()
        func_set_data()
    }
    
    func set_grad() {
        set_gradient_on_label(lbl: lbl_my_bag)
        set_gradient_on_label(lbl: lbl_total_items)
        set_gradient_on_label(lbl: lbl_total_to_pay)
        set_gradient_on_label(lbl: lbl_delivery_charge)
        set_gradient_on_label(lbl: lbl_subtotal)
        set_gradient_on_label(lbl: lbl_free)
        set_gradient_on_label(lbl: lbl_standard_delivery)
        set_gradient_on_label(lbl: lbl_delivered_on_before)
        set_gradient_on_label(lbl: lbl_free_1)
        set_gradient_on_label(lbl: lbl_standard_delivery_1)
        set_gradient_on_label(lbl: lbl_delivered_on_before_1)
        set_gradient_on_label(lbl: lbl_tax_name)
        set_gradient_on_label(lbl: lbl_taxt_value)
        
        set_gradient_on_label(lbl: lbl_sub_total_title)
        set_gradient_on_label(lbl: lbl_delivery)
        set_gradient_on_label(lbl: lbl_customer_wallet)
        set_gradient_on_label(lbl: lbl_total_to_pay_title)
        
        lbl_subtotal.text = "subtotal".localized
        lbl_delivery.text = "Delivery".localized
        lbl_discount.text = "discount".localized
        lbl_total_to_pay_title.text = "totaltopay".localized
        lbl_customer_wallet.text = "usewallet".localized
        
        btn_apply.setTitle("apply".localized, for: .normal)
        btn_continue.setTitle("checkout".localized, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func_set_address()
    }
    
    @objc func func_save_address() {
        func_get_delivery_type()
        func_set_data()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func func_set_address() {
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            lbl_full_name.text = "\(dict_LoginData["shipping_name"] ?? "")"
            lbl_address_1.text = "\(dict_LoginData["shipping_address1"] ?? "")"
            lbl_address_2.text = "\(dict_LoginData["shipping_address2"] ?? "")"
            lbl_town_city.text = "\(dict_LoginData["shipping_city"] ?? "")"
            lbl_state.text = "\(dict_LoginData["shipping_state"] ?? "")"
            lbl_country.text = "\(dict_LoginData["country_name"] ?? "")"
            lbl_postcode.text = "\(dict_LoginData["customer_postcode"] ?? "")"
            
            let shipping_mobile_1 = "\(dict_LoginData["shipping_mobile"] ?? "")".components(separatedBy: "-")
            var country_code_1 = ""
            if shipping_mobile_1.count > 0 {
                country_code_1 = shipping_mobile_1[0]
            }
            
            var phone_number_1 = ""
            if shipping_mobile_1.count > 1 {
                phone_number_1 = shipping_mobile_1[1]
            }
            
            lbl_mobile_number.text = country_code_1+phone_number_1
            
//            if lbl_country.text!.contains("Saudi Arabia") {
                height_express_delivery.constant = 0
                view_exp_delivery.isHidden = true
                hieght_delivery_option.constant = 110
                view_container.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: view_container.frame.size.height-view_exp_delivery.frame.size.height)
                btn_delivery_express.isHidden = true
//            } else {
//                height_express_delivery.constant = 50
//                view_exp_delivery.isHidden = false
//                hieght_delivery_option.constant = 180
//                btn_delivery_express.isHidden = false
//                view_container.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: view_container.frame.size.height+30)
//            }
            
            tbl_payment.reloadData()
            
            let taxt_percent = "\(dict_LoginData["country_tax"] ?? "0")"
            let country_tax_name = "\(dict_LoginData["country_tax_name"] ?? "")"
            lbl_tax_name.text = "\(country_tax_name) \(taxt_percent)%"
            
            str_delivery_address = "\(lbl_full_name.text!), \(lbl_address_1.text!),, \(lbl_address_2.text!) \(lbl_town_city.text!) , \(lbl_state.text!) , \(lbl_country.text!), \(lbl_postcode.text!) , \(lbl_mobile_number.text!)"
            
            total_price = 0.0
            
            for i in 0..<Model_Bag.shared.arr_view_cart.count {
                let model = Model_Bag.shared.arr_view_cart[i]
                
                if !model.product_price.isEmpty {
                    let full_price = Double(model.currency_price)!*Double(model.product_price)!
                    total_price = total_price + (full_price * Double(Int(model.cart_product_qty)!))
                }
            }
            
            let double_taxt_percent = Double(taxt_percent)
            tax_calculation = (total_price * double_taxt_percent!)/100
            print(tax_calculation)
            //            let full_price = Double(currency_price)!*Double(tax_calculation)
            lbl_taxt_value.text = "\(String(format: "%.2f", tax_calculation)) \(currency_symbol)"
            lbl_taxt_value.text = "\(arabic_digits(String(format: "%.2f", tax_calculation))) \(currency_symbol)"
            
            total_price = Double(String(format: "%.2f", total_price))!
            
            let str_shipping_note = "\(dict_LoginData["shipping_note"] ?? "")"
            lbl_delivery_instruction.text = str_shipping_note
            
            let customer_wallet = "\(dict_LoginData["customer_wallet"] ?? "")"
            if customer_wallet == "0" {
                //                lbl_customer_wallet.text = ""
                top_customer_wallet.constant = 0
                height_customer_wallet.constant = 0
                view_customer_wallet.isHidden = true
                view_container.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: view_container.frame.size.height-view_customer_wallet.frame.size.height)
                
                height_pay_container.constant = 344
            } else {
                view_customer_wallet.isHidden = false
            }
            
            if str_shipping_note.isEmpty {
                height_delivery_instrutction.constant = 0
                view_delivery_instrutction.isHidden = true
                view_container.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: view_container.frame.size.height-view_delivery_instrutction.frame.size.height)
            } else {
                height_delivery_instrutction.constant = 100
                view_delivery_instrutction.isHidden = false
            }
            
            tbl_payment.reloadData()
        }
    }
    
    func func_set_data() {
        btn_use_walllet.isSelected = false
        txt_coupon.text = ""
        Model_payment_checkout.shared.wallet_amount = "0"
        
        lbl_coupon.isHidden = true
        top_discount.constant = 0
        height_discount.constant = 0
        view_discount.isHidden = true
        
        height_pay_container.constant = 344
        view_container.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: view_container.frame.size.height-view_discount.frame.size.height)
        
        let items = "items".localized
        lbl_total_items.text = "\(Model_Bag.shared.arr_view_cart.count) \(items))"
        lbl_subtotal.text = "\(arabic_digits("\(total_price)")) \(currency_symbol)"
        self.lbl_delivery_charge.text = "\(self.arabic_digits("\(delivery_charge)")) \(currency_symbol)"
        
        full_amt = total_price+tax_calculation+delivery_charge
        
        lbl_total_to_pay.text = "\(arabic_digits(String(format: "%.2f", full_amt))) \(currency_symbol)"
    }
    
    func func_set_corner_radius(object:UIView) {
            object.layer.cornerRadius = object.frame.size.height / 2
    }
    
    func func_get_delivery_type() {
        DispatchQueue.main.async {
            self.func_ShowHud()
        }
        
        Model_payment_checkout.shared.func_get_delivery_type { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    for model in Model_payment_checkout.shared.arr_get_delivery_type {
                        if model.delivery_description.lowercased().contains("\(self.lbl_country.text!.lowercased())") {
                            self.lbl_free.text = "Coast: "+model.delivery_type_cost
                            self.lbl_standard_delivery.text = model.delivery_type
                            self.lbl_delivered_on_before.text = "\(model.delivery_days)"
                            
                            if model.delivery_type_cost.isEmpty {
                                self.delivery_charge = 0.0
                            } else {
                                self.delivery_charge = Double(model.delivery_type_cost.components(separatedBy: " ")[0])!
                            }
                            
                            self.str_delivery_type_id = model.delivery_type_id
                            
                            break
                        } else if model.delivery_description.lowercased().contains("Other".lowercased()) {
                            self.lbl_free.text = "Coast: "+model.delivery_type_cost
                            self.lbl_standard_delivery.text = model.delivery_type
                            self.lbl_delivered_on_before.text = "\(model.delivery_days)"
                            
                            self.str_delivery_type_id = model.delivery_type_id
                            
                            if model.delivery_type_cost.isEmpty {
                                self.delivery_charge = 0.0
                            } else {
                                self.delivery_charge = Double(model.delivery_type_cost.components(separatedBy: " ")[0])!
                            }
                            
                            break
                        }
                    }
                    
                    
                    
//                    let model = Model_payment_checkout.shared.arr_get_delivery_type[0]
//                    print(self.lbl_country.text)
                    
//                    self.lbl_free.text = model.delivery_type_cost
//                    self.lbl_standard_delivery.text = model.delivery_type
//                    self.lbl_delivered_on_before.text = "\(model.delivery_description) \(model.delivery_days)"
                    
//                    let model_1 = Model_payment_checkout.shared.arr_get_delivery_type[1]
//                    let arr_delivery_type_cost = model_1.delivery_type_cost.components(separatedBy: " ")
//                    if arr_delivery_type_cost.count > 0 {
//                        let express_delivery_charge = Double(arr_delivery_type_cost[0])!
//                        let full_price_DC = Double(currency_price)!*express_delivery_charge
////                        self.lbl_free_1.text = "\(String(format: "%.2f", full_price_DC)) \(currency_symbol)"
//                        self.lbl_free_1.text = "\(self.arabic_digits("\(full_price_DC)")) \(currency_symbol)"
//                    } else {
//                        self.lbl_free_1.text = "Api se galat aa rhi value"
//                    }
//
//                    self.lbl_standard_delivery_1.text = model_1.delivery_type
//                    self.lbl_delivered_on_before_1.text = "\(model_1.delivery_description) \(model_1.delivery_days)"
                    
//                    self.str_delivery_type_id = Model_payment_checkout.shared.arr_get_delivery_type[0].delivery_type_id
                } else {
                    self.lbl_free.text = ""
                    self.lbl_standard_delivery.text = ""
                    self.lbl_delivered_on_before.text = ""
                    
                    self.lbl_free_1.text = ""
                    self.lbl_standard_delivery_1.text = ""
                    self.lbl_delivered_on_before_1.text = ""
                }
                
                DispatchQueue.main.async {
                    self.func_set_data()
                }
            }
        }
    }
    
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("checkout"), object: nil)
    }
    
    @IBAction func btn_change_my_bag(_ sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_change_delivery_address(_ sender:UIButton) {
        let shipping_add = storyboard?.instantiateViewController(withIdentifier: "Address_ViewController") as! Address_ViewController
        present(shipping_add, animated: true, completion: nil)
    }
    
    @IBAction func btn_change_payment_type(_ sender:UIButton) {
        let shipping_add = storyboard?.instantiateViewController(withIdentifier: "Payment_methods_List_ViewController") as! Payment_methods_List_ViewController
        present(shipping_add, animated: true, completion: nil)
    }
    
    @IBAction func btn_delivery_free(_ sender:UIButton) {
        btn_delivery_free.isSelected = true
        btn_delivery_express.isSelected = false
        
        delivery_type_cost = Model_payment_checkout.shared.arr_get_delivery_type[0].delivery_type_cost
        
        lbl_delivery_charge.text = "free".localized
        
        full_amt = total_price+tax_calculation
        
        if is_promocode {
//            lbl_total_to_pay.text = "\(String(format: "%.2f", full_amt-discount_promo)) \(currency_symbol)"
        lbl_total_to_pay.text = "\(arabic_digits("\(full_amt-discount_promo)")) \(currency_symbol)"
        } else {
//            lbl_total_to_pay.text = "\(String(format: "%.2f", total_price+tax_calculation)) \(currency_symbol)"
            lbl_total_to_pay.text = "\(arabic_digits("\(total_price+tax_calculation)")) \(currency_symbol)"
        }
        
        shipping_cost = "0"
        self.str_delivery_type_id = Model_payment_checkout.shared.arr_get_delivery_type[0].delivery_type_id
        
        if is_wallet {
            let btn = UIButton()
            btn_use_walllet(btn)
        }
        
    }
    
    
    
    @IBAction func btn_delivery_express(_ sender:UIButton) {
        btn_delivery_free.isSelected = false
        btn_delivery_express.isSelected = true
        
        let str_delivery_type_cost = Model_payment_checkout.shared.arr_get_delivery_type[1].delivery_type_cost
        let arr_delivery_cost = str_delivery_type_cost.components(separatedBy:" ")
        let full_price = (Double(currency_price)!*Double(Int(arr_delivery_cost[0])!))*Double(Model_Bag.shared.arr_view_cart.count)
        
//        lbl_delivery_charge.text = "\(String(format: "%.2f", full_price)) \(currency_symbol)"
        lbl_delivery_charge.text = "\(arabic_digits("\(full_price)")) \(currency_symbol)"
        
        full_amt = total_price+tax_calculation+full_price
        
        if is_promocode {
//            lbl_total_to_pay.text = "\(String(format: "%.2f", full_amt-discount_promo)) \(currency_symbol)"
            
            lbl_total_to_pay.text = "\(arabic_digits("\(full_amt-discount_promo)")) \(currency_symbol)"
        } else {
            lbl_total_to_pay.text = "\(arabic_digits("\(total_price+tax_calculation+full_price)")) \(currency_symbol)"
//            lbl_total_to_pay.text = "\(String(format: "%.2f", total_price+tax_calculation+full_price)) \(currency_symbol)"
        }
        
        shipping_cost = arr_delivery_cost[0]
        self.str_delivery_type_id = Model_payment_checkout.shared.arr_get_delivery_type[1].delivery_type_id
        
        if is_wallet {
            let btn = UIButton()
            btn_use_walllet(btn)
        }
        
    }
    
    
    
    @IBAction func btn_continue(_ sender:UIButton) {
        if !func_validation() {
            return
        }
        
        let str_total_pay = lbl_total_to_pay.text!.components(separatedBy: " ")
        if str_total_pay[1] == "0" {
            Model_payment_checkout.shared.payment_method_type = "PayPal"
            func_order_placed()
        } else {
            func_pay_method()
        }
    }
    
    func func_pay_method() {
        Model_payment_checkout.shared.delivery_charges = shipping_cost
        total_pay_product_price = (lbl_total_to_pay.text?.components(separatedBy: " ")[0])!
        
        let payment_methods_VC = storyboard?.instantiateViewController(withIdentifier: "Payment_Methods_ViewController") as! Payment_Methods_ViewController
        present(payment_methods_VC, animated: true, completion: nil)
    }
    
    func func_validation() -> Bool {
        var is_false = false
        if lbl_address_1.text!.isEmpty {
              func_ShowHud_Error(with: "Complete your shipping address")
            is_false = false
        } else if lbl_address_2.text!.isEmpty {
            func_ShowHud_Error(with: "Complete your shipping address")
            is_false = false
        } else if lbl_town_city.text!.isEmpty {
             func_ShowHud_Error(with: "Complete your shipping address")
            is_false = false
        }  else if lbl_state.text!.isEmpty {
            func_ShowHud_Error(with: "Complete your shipping address")
            is_false = false
        } else if lbl_country.text!.isEmpty {
              func_ShowHud_Error(with: "Complete your shipping address")
            is_false = false
        } else if lbl_postcode.text!.isEmpty {
              func_ShowHud_Error(with: "Complete your shipping address")
            is_false = false
        } else if lbl_mobile_number.text!.isEmpty {
            func_ShowHud_Error(with: "Complete your shipping address")
            is_false = false
        } else if str_payment_type == "Select payment type" {
//            func_ShowHud_Error(with: "Select payment type")
//            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//                self.func_HideHud()
//            }
            is_false = true
        } else {
            is_false = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.func_HideHud()
        }
        return is_false
    }
    
    @objc func func_order_placed() {
        func_ShowHud()
        
        Model_payment_checkout.shared.delivery_address = str_delivery_address
//        Model_payment_checkout.shared.payment_method_type = str_payment_type
        Model_payment_checkout.shared.delivery_type_id = str_delivery_type_id
        
        let str_total_pay = lbl_total_to_pay.text!.components(separatedBy: " ")
        Model_payment_checkout.shared.order_amount = str_total_pay[0]
        
        Model_payment_checkout.shared.func_order_placed { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                Model_payment_checkout.shared.isFROM_WALLET = false
                Model_payment_checkout.shared.promo_code_discount = "0"
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_payment_checkout.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_payment_checkout.shared.str_message)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: Notification.Name("checkout"), object: nil)
                    NotificationCenter.default.post(name: NSNotification.Name (rawValue: "Bag_count"), object: nil)
                })
            }
        }
    }
    
    
    
    @IBAction func btn_use_walllet(_ sender:UIButton) {
        lbl_coupon.isHidden = true
        top_discount.constant = 0
        height_discount.constant = 0
        view_discount.isHidden = true
        txt_coupon.text = ""
        Model_payment_checkout.shared.promo_code_discount = "0"
        
        sender.isSelected = !(sender.isSelected)
        is_wallet = sender.isSelected
        Model_payment_checkout.shared.isFROM_WALLET = sender.isSelected
        
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            let customer_wallet = "\(dict_LoginData["customer_wallet"] ?? "")"
            let customer_wallet_1 = Double(customer_wallet)!*Double(currency_price)!
            
            if sender.isSelected {
                let new_amt = full_amt-customer_wallet_1
                
//                if is_promocode {
//                    new_amt = full_amt-customer_wallet_1
//                }
                
                if new_amt < 0 {
                    lbl_total_to_pay.text = "0 \(currency_symbol)"
                } else {
//                    if is_promocode {
//                        lbl_total_to_pay.text = "\(String(format: "%.2f", new_amt-discount_promo)) \(currency_symbol)"
//                    } else {
//                        lbl_total_to_pay.text = "\(String(format: "%.2f", new_amt)) \(currency_symbol)"
                        lbl_total_to_pay.text = "\(arabic_digits("\(new_amt)")) \(currency_symbol)"
//                    }
                }
            } else {
//                lbl_total_to_pay.text = "\(String(format: "%.2f", full_amt)) \(currency_symbol)"
                lbl_total_to_pay.text = "\(arabic_digits("\(full_amt)")) \(currency_symbol)"
            }
        }
    }
    
    func func_disable_wallet() {
        Model_payment_checkout.shared.wallet_amount = "0"
//        lbl_total_to_pay.text = "\(String(format: "%.2f", full_amt)) \(currency_symbol)"
        lbl_total_to_pay.text = "\(arabic_digits("\(full_amt)")) \(currency_symbol)"
        
        self.func_hide_discount()
        tbl_payment.reloadData()
    }
    
    @IBAction func btn_apply_wallet(_ sender:UIButton) {
        self.view.endEditing(true)
        
        if txt_coupon.text!.isEmpty {
            func_ShowHud_Error(with: "Enter your coupon code")
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.func_HideHud()
            }
            return
        }
        
        btn_use_walllet.isSelected = false
        func_disable_wallet()
        
        Model_payment_checkout.shared.promo_code = txt_coupon.text!
        func_ShowHud()
        Model_payment_checkout.shared.func_apply_promo_code { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                self.lbl_coupon.isHidden = false
                
                let model = Model_Bag.shared.arr_view_cart[0]
                
                if status == "success" {
                    self.is_promocode = true
                    let promo_code_discount = Double(Model_payment_checkout.shared.promo_code_discount)!*Double(model.currency_price)!
                    if Model_payment_checkout.shared.promo_code_type == "1" {
                        self.func_show_discount()
                        
                        let coupon = "coupn".localized
                        let successapply = "successapply".localized
                        
                        self.lbl_coupon.text = "\(coupon) \(self.txt_coupon.text!) \(successapply)"
                        
                        let mini_amount_to_use = (Double(Model_payment_checkout.shared.mini_amount_to_use)!*Double(model.currency_price)!)-1.0
//                        let mini_amount_to_use = Double(Model_payment_checkout.shared.mini_amount_to_use)!-1.0
                        
                        if self.full_amt > mini_amount_to_use {
                            self.discount_promo = ((self.full_amt*promo_code_discount)/100)
                            
                            let maximum_discount = Double(Model_payment_checkout.shared.maximum_discount)!*Double(model.currency_price)!
                            
                            if self.discount_promo > maximum_discount {
//                                self.lbl_discount_value.text = "\(String(format: "%.2f", maximum_discount)) \(currency_symbol)"
                                self.lbl_discount_value.text = "\(self.arabic_digits("\(maximum_discount)")) \(currency_symbol)"
                                
                                let new_full_amt = self.full_amt - maximum_discount
//                                self.lbl_total_to_pay.text = "\(String(format: "%.2f", new_full_amt)) \(currency_symbol)"
                                self.lbl_total_to_pay.text = "\(self.arabic_digits("\(new_full_amt)")) \(currency_symbol)"
                            } else {
//                                self.lbl_discount_value.text = "\(String(format: "%.2f", self.discount_promo)) \(currency_symbol)"
                                self.lbl_discount_value.text = "\(self.arabic_digits("\(self.discount_promo)")) \(currency_symbol)"
                                
                                let new_full_amt = self.full_amt - self.discount_promo
//                                self.lbl_total_to_pay.text = "\(String(format: "%.2f", new_full_amt)) \(currency_symbol)"
                                self.lbl_total_to_pay.text = "\(self.arabic_digits("\(new_full_amt)")) \(currency_symbol)"
                            }
                        } else {
                            self.lbl_coupon.text = "Bag amount not sufficient"
                            Model_payment_checkout.shared.promo_code_discount = "0"
                            self.func_hide_discount()
                        }
                    } else {
                        self.func_show_discount()
                        self.lbl_coupon.text = "Coupon \(self.txt_coupon.text!) successfully applied"
                        
                        let mini_amount_to_use = (Double(Model_payment_checkout.shared.mini_amount_to_use)!*Double(model.currency_price)!)-1.0
                        if self.full_amt > mini_amount_to_use {
                            self.discount_promo = promo_code_discount
//                            self.lbl_discount_value.text = "\(String(format: "%.2f", self.discount_promo)) \(currency_symbol)"
                            self.lbl_discount_value.text = "\(self.arabic_digits("\(self.discount_promo)")) \(currency_symbol)"
                            
                            let new_full_amt = self.full_amt-promo_code_discount
//                            self.lbl_total_to_pay.text = "\(String(format: "%.2f", new_full_amt)) \(currency_symbol)"
                            self.lbl_total_to_pay.text = "\(self.arabic_digits("\(new_full_amt)")) \(currency_symbol)"
                        } else {
                            self.func_hide_discount()
                            Model_payment_checkout.shared.promo_code_discount = "0"
                            self.lbl_coupon.text = "Bag amount not sufficient"
                        }
                    }
                } else {
                    Model_payment_checkout.shared.promo_code_discount = ""
                    self.is_promocode = false
                    self.discount_promo = 0.0
                    self.lbl_coupon.text = Model_payment_checkout.shared.str_message
//                    self.lbl_total_to_pay.text = "\(String(format: "%.2f", self.full_amt)) \(currency_symbol)"
                    self.lbl_total_to_pay.text = "\(self.arabic_digits("\(self.full_amt)")) \(currency_symbol)"
                    
                    self.func_hide_discount()
                }
                
                self.tbl_payment.reloadData()
                
//                if self.is_wallet {
//                    let btn = UIButton()
//                    self.btn_use_walllet(btn)
//                }
                
            }
        }
    }
    
    
    
    func func_show_discount() {
        self.top_discount.constant = 20
        self.height_discount.constant = 40
        self.view_discount.isHidden = false
        
        self.height_pay_container.constant = 400
        self.view_container.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height:self.view_container.frame.size.height+self.height_discount.constant)
    }
    
    func func_hide_discount() {
        self.top_discount.constant = 0
        self.height_discount.constant = 0
        self.view_discount.isHidden = true
        
        self.height_pay_container.constant = 344
        self.view_container.frame = CGRect (x: 0, y: 0, width: self.view.frame.size.width, height:self.view_container.frame.size.height-view_discount.frame.size.height)
    }
    
    
    
}



//  MARK:- UICollectionView methods
extension Payment_checkout_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: 60, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if is_from_order {
            return 1
        } else {
            return Model_Bag.shared.arr_view_cart.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Payment_checkout_CollectionViewCell
        
        if is_from_order {
            cell.img_spacks.sd_setShowActivityIndicatorView(true)
            cell.img_spacks.sd_setIndicatorStyle(.gray)
            
            let u = Model_payment_checkout.shared.model_order.product_image
            let img_name = u.components(separatedBy: k_images_url)
            if img_name.count > 1 {
                let img_ = img_name[1]
                if let encoded = img_.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    let u = "\(k_images_url)/\(encoded)"
                    let url = URL(string:u)
                    cell.img_spacks.sd_setImage(with:url!, placeholderImage:img_default_app)
                }
            } else {
                cell.img_spacks.sd_setImage(with:URL (string: u), placeholderImage:img_default_app)
            }
        } else {
            let model = Model_Bag.shared.arr_view_cart[indexPath.row]
            
            cell.lbl_product_name.text = model.product_name
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
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        is_details_item = false
    }
    
}


