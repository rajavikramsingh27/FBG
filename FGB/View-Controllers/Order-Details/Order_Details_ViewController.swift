//  Order_Details_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 15/04/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit



class Order_Details_ViewController: UIViewController { //, PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate {
    @IBOutlet weak var nav_bar:UINavigationItem!
    @IBOutlet weak var btn_continue:UIButton!
    
    @IBOutlet weak var lbl_my_bag:UILabel!
    @IBOutlet weak var lbl_total_items:UILabel!
    
    @IBOutlet weak var lbl_subtotal_title:UILabel!
    @IBOutlet weak var lbl_subtotal:UILabel!
    @IBOutlet weak var lbl_delivery_charge:UILabel!
    @IBOutlet weak var lbl_total_to_pay_title:UILabel!
    @IBOutlet weak var lbl_total_to_pay:UILabel!
    
    @IBOutlet weak var lbl_about:UILabel!
    @IBOutlet weak var lbl_about_order:UILabel!
    @IBOutlet weak var lbl_description:UILabel!
    @IBOutlet weak var lbl_description_order:UILabel!
    
    @IBOutlet weak var lbl_tax_name:UILabel!
    @IBOutlet weak var lbl_tax_value:UILabel!
    
    @IBOutlet weak var lbl_delivery_address:UILabel!
    @IBOutlet weak var lbl_delivery_address_1:UILabel!
    
    @IBOutlet weak var lbl_delivery_type:UILabel!
    @IBOutlet weak var lbl_delivery_type_1:UILabel!
    
    @IBOutlet weak var lbl_payment_type:UILabel!
    @IBOutlet weak var lbl_payment_type_1:UILabel!
    
    @IBOutlet weak var lbl_order_status:UILabel!
    @IBOutlet weak var lbl_order_status_1:UILabel!
    
    @IBOutlet weak var lbl_product_cost:UILabel!
    
    @IBOutlet weak var lbl_delivery:UILabel!
    @IBOutlet weak var lbl_delivery_1:UILabel!
    
    @IBOutlet weak var lbl_total_amt:UILabel!
    @IBOutlet weak var lbl_total_amt_1:UILabel!
    
    @IBOutlet weak var lbl_discount_amt:UILabel!
    @IBOutlet weak var lbl_discount_amt_1:UILabel!
    
    @IBOutlet weak var view_container:UIView!
    
    @IBOutlet weak var tbl_payment:UITableView!
    
    @IBOutlet weak var height_discount:NSLayoutConstraint!
    @IBOutlet weak var top_discount:NSLayoutConstraint!
    @IBOutlet weak var view_discount:UIView!
    
    var delegate: reload_bag!
    
    var total_price = 0.0
    var delivery_type_cost = ""
    var shipping_cost = "0"
    
    var str_delivery_address = ""
    var str_delivery_type_id = ""
    
    var tax_calculation = 0.0
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_bar.title = "cencelorder".localized
        
        is_checkout = true
        func_set_corner_radius(object: btn_continue)
        btn_continue.setTitle("cencelorder".localized, for: .normal)
        
//        func_paypal_setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_order_placed), name: NSNotification.Name (rawValue: "paypal_payment"), object: nil)
        
        lbl_delivery_charge.text = "free".localized
        set_grad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        PayPalMobile.preconnect(withEnvironment: environment)
        func_set_ordered_data()
    }
    
    func set_grad() {
        set_gradient_on_label(lbl: lbl_my_bag)
        set_gradient_on_label(lbl: lbl_total_items)
        
        set_gradient_on_label(lbl: lbl_subtotal_title)
        set_gradient_on_label(lbl: lbl_subtotal)
        
        set_gradient_on_label(lbl: lbl_delivery_charge)
        set_gradient_on_label(lbl: lbl_total_to_pay_title)
        set_gradient_on_label(lbl: lbl_total_to_pay)
        
        set_gradient_on_label(lbl: lbl_about)
        set_gradient_on_label(lbl: lbl_about_order)
        
        set_gradient_on_label(lbl: lbl_description)
        set_gradient_on_label(lbl: lbl_description_order)
        
        set_gradient_on_label(lbl: lbl_tax_name)
        set_gradient_on_label(lbl: lbl_tax_value)
        
        set_gradient_on_label(lbl: lbl_delivery_address)
        set_gradient_on_label(lbl: lbl_delivery_address_1)
        
        set_gradient_on_label(lbl: lbl_delivery_type)
        set_gradient_on_label(lbl: lbl_delivery_type_1)
        
        set_gradient_on_label(lbl: lbl_delivery_type)
        set_gradient_on_label(lbl: lbl_delivery_type_1)
        
        set_gradient_on_label(lbl: lbl_payment_type)
        set_gradient_on_label(lbl: lbl_payment_type_1)
        
        set_gradient_on_label(lbl: lbl_order_status)
        set_gradient_on_label(lbl: lbl_order_status_1)
        
        set_gradient_on_label(lbl: lbl_product_cost)
        
        set_gradient_on_label(lbl: lbl_delivery)
//        set_gradient_on_label(lbl: lbl_delivery_1)
        
        set_gradient_on_label(lbl: lbl_total_amt)
        set_gradient_on_label(lbl: lbl_total_amt_1)
        
        set_gradient_on_label(lbl: lbl_discount_amt)
        set_gradient_on_label(lbl: lbl_discount_amt_1)
        
        lbl_about.text = "aboutproduct".localized
        lbl_description.text = "describtion".localized
        lbl_delivery_address.text = "deveryaddress".localized
        
        lbl_payment_type.text = "PaymentMethod".localized
        lbl_delivery_type.text = "Deliverytye".localized
        lbl_product_cost.text = "productcost".localized
        
        lbl_subtotal_title.text = "subtotal".localized
        lbl_delivery.text = "Delivery".localized
        lbl_order_status.text = "orderstatus".localized
        
        lbl_total_amt.text = "totalamount".localized
//        lbl_discount_amt.text = "discount".localized
        lbl_total_to_pay_title.text = "totalpaid".localized
    }
    
    func func_set_data() {
//        lbl_total_items.text = "\(Model_Bag.shared.arr_view_cart.count) items"
        let model = Model_payment_checkout.shared.model_order
        
        var wallet_discount = 0.0
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
//            lbl_full_name.text = "\(dict_LoginData["shipping_name"] ?? "")"
            let taxt_percent = "\(dict_LoginData["country_tax"] ?? "0")"
            let country_tax_name = "\(dict_LoginData["country_tax_name"] ?? "")"
            lbl_tax_name.text = "\(country_tax_name) \(taxt_percent)%"
            
            for i in 0..<Model_Bag.shared.arr_view_cart.count {
                let model = Model_Bag.shared.arr_view_cart[i]
                
                if !model.product_price.isEmpty {
                    let full_price = Double(model.currency_price)!*Double(model.product_price)!
                    total_price = total_price + (full_price * Double(Int(model.cart_product_qty)!))
                }
            }
            
            if (model.wallet_discount.isEmpty || model.wallet_discount == "0") && (model.promo_discount.isEmpty || model.promo_discount == "0") {
                wallet_discount = 0.0
                top_discount.constant = 0
                height_discount.constant = 0
                view_discount.isHidden = true
            } else {
                if model.wallet_discount != "0" {
                    lbl_discount_amt.text = "Wallet Discount".localized
                    wallet_discount = Double(model.currency_price)!*Double(model.wallet_discount)!
                }
                
                if model.promo_discount != "0" {
                    lbl_discount_amt.text = "Promo Discount".localized
                    wallet_discount = Double(model.currency_price)!*Double(model.promo_discount)!
                }
                
                top_discount.constant = 16
                height_discount.constant = 24
                view_discount.isHidden = false
            }
            
            tax_calculation = (total_price*Double(Int(taxt_percent)!))/100
//            lbl_tax_value.text = "\(String(format: "%.2f", tax_calculation)) \(model.currency_name)"
            lbl_tax_value.text = "\(arabic_digits("\(tax_calculation)")) \(model.currency_name)"
            total_price = Double(String(format: "%.2f", total_price))!
        }
        
//        lbl_subtotal.text = "\(total_price) \(model.currency_name)"
        lbl_subtotal.text = "\(arabic_digits("\(total_price)")) \(model.currency_name)"
        lbl_discount_amt_1.text = "-\(String(format: "%.2f", wallet_discount)) \(model.currency_name)"
//        lbl_discount_amt_1.text = "-\(arabic_digits("\(wallet_discount)")) \(model.currency_name)"
        
        if model.delivery_type == "Standard Delivery" {
//            lbl_subtotal.text = "\(total_price) \(model.currency_name)"
            lbl_subtotal.text = "\(arabic_digits("\(total_price)")) \(model.currency_name)"
            lbl_delivery_charge.text = "free".localized
            
//            lbl_total_amt_1.text = "\(String(format: "%.2f",(total_price+tax_calculation))) \(model.currency_name)"
            lbl_total_amt_1.text = "\(arabic_digits("\(total_price+tax_calculation)")) \(model.currency_name)"
            let final_price = String(format: "%.2f", (total_price+tax_calculation)-wallet_discount).replacingOccurrences(of: "-", with: "")
            
//            lbl_total_to_pay.text = "\(final_price) \(model.currency_name)"
            lbl_total_to_pay.text = "\(arabic_digits("\(final_price)")) \(model.currency_name)"
        } else {
            let str_delivery_type_cost = model.delivery_type_cost
            let arr_delivery_cost = str_delivery_type_cost.components(separatedBy:" ")
            
//            lbl_subtotal.text = "\(total_price) \(model.currency_name)"
            lbl_subtotal.text = "\(arabic_digits("\(total_price)")) \(model.currency_name)"
            let full_price_1 = Double(currency_price)!*Double(Int(arr_delivery_cost[0])!)
            
//            lbl_delivery_charge.text = "\(String(format: "%.2f",full_price_1)) \(model.currency_name)"
            lbl_delivery_charge.text = "\(arabic_digits("\(full_price_1)")) \(model.currency_name)"
//            lbl_total_amt_1.text = "\(String(format: "%.2f",(total_price+tax_calculation+full_price_1))) \(model.currency_name)"
            lbl_total_amt_1.text = "\(arabic_digits("\(total_price+tax_calculation+full_price_1)")) \(model.currency_name)"
            let final_price = String(format: "%.2f", (total_price+tax_calculation+full_price_1)-wallet_discount).replacingOccurrences(of: "-", with: "")
            lbl_total_to_pay.text = "\(arabic_digits("\(final_price)")) \(model.currency_name)"
//            lbl_total_to_pay.text = "\(final_price) \(model.currency_name)"
        }
        
    }
    
    
    
    
    func func_set_ordered_data() {
        nav_bar.title = "orderdetails".localized
        
        let model = Model_payment_checkout.shared.model_order
        
        btn_continue.isHidden = false
        if model.order_product_status == "0" {
            lbl_order_status_1.text = "orderplaced".localized
        } else if model.order_product_status == "1" {
            lbl_order_status_1.text = "processing".localized
        } else if model.order_product_status == "2" {
            lbl_order_status_1.text = "completed".localized
            btn_continue.isHidden = true
        } else {
            lbl_order_status_1.text = "cenceled".localized
            btn_continue.isHidden = true
        }
        
        lbl_about_order.text = model.product_about
        lbl_description_order.text = model.product_description
        lbl_delivery_type_1.text = model.delivery_type
        lbl_payment_type_1.text = model.payment_method_type
        
        lbl_delivery_address_1.text = model.delivery_address .replacingOccurrences(of: ", ", with: "\n")
        let double_currency_price = Double(model.currency_price)
        let double_product_price = Double(model.product_price)
        let double_order_product_qty = Double(model.order_product_qty)
        
        total_price = double_currency_price!*double_product_price!*double_order_product_qty!
        
        let taxt_percent = model.tax_rate
        tax_calculation = (total_price*Double(Int(taxt_percent)!))/100
        print(tax_calculation)
//        lbl_tax_value.text = "\(String(format: "%.2f", tax_calculation)) \(model.currency_name)"
        lbl_tax_value.text = "\(arabic_digits("\(tax_calculation)")) \(model.currency_name)"
//        total_price = Double(String(format: "%.2f", total_price))!
        
        let country_tax_name = model.taxname
        lbl_tax_name.text = "\(country_tax_name) \(taxt_percent)%"
        
        let items = "items".localized
        lbl_total_items.text = "\(model.order_product_qty) \(items)"
        lbl_my_bag.text = "myorder".localized
        
        func_set_data()
        tbl_payment.reloadData()
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
                    let model = Model_payment_checkout.shared.arr_get_delivery_type[0]
                    let model_1 = Model_payment_checkout.shared.arr_get_delivery_type[1]
                    self.str_delivery_type_id = Model_payment_checkout.shared.arr_get_delivery_type[0].delivery_type_id
                } else {
                    
                }
//                self.func_set_data()
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
    
    
    
    @IBAction func btn_continue(_ sender:UIButton) {
        if !func_validation() {
            return
        }
        Model_payment_checkout.shared.delivery_charges = shipping_cost
        func_order_placed()
    }
    
    func func_validation() -> Bool {
        var is_false = false
//        if lbl_address.text!.isEmpty {
//            func_ShowHud_Error(with: "Complete your shipping address")
//            is_false = false
//        } else if lbl_town_city.text!.isEmpty {
//            func_ShowHud_Error(with: "Complete your shipping address")
//            is_false = false
//        } else if lbl_country.text!.isEmpty {
//            func_ShowHud_Error(with: "Complete your shipping address")
//            is_false = false
//        } else if lbl_postcode.text!.isEmpty {
//            func_ShowHud_Error(with: "Complete your shipping address")
//            is_false = false
//        } else if str_payment_type == "Select payment type" {
//            //            func_ShowHud_Error(with: "Select payment type")
//            //            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            //                self.func_HideHud()
//            //            }
//            is_false = true
//        } else {
//            is_false = true
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.func_HideHud()
        }
        return is_false
    }
    
    @objc func func_order_placed() {
        func_ShowHud()
        
        Model_payment_checkout.shared.delivery_address = str_delivery_address
        Model_payment_checkout.shared.payment_method_type = str_payment_type
        Model_payment_checkout.shared.delivery_type_id = str_delivery_type_id
        
        let str_total_pay = lbl_total_to_pay.text!.components(separatedBy: " ")
        Model_payment_checkout.shared.order_amount = str_total_pay[0]
        
        Model_payment_checkout.shared.func_order_placed { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    NotificationCenter.default.post(name: NSNotification.Name (rawValue: "Bag_count"), object: nil)
                    self.func_ShowHud_Success(with: Model_payment_checkout.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_payment_checkout.shared.str_message)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
}



//  MARK:- UICollectionView methods
extension Order_Details_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if is_from_order {
            return 1
        } else {
            return Model_Bag.shared.arr_view_cart.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Order_Details_CollectionViewCell
        
        if is_from_order {
            cell.img_spacks.sd_setShowActivityIndicatorView(true)
            cell.img_spacks.sd_setIndicatorStyle(.gray)
            
            let model = Model_payment_checkout.shared.model_order
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
                cell.img_spacks.sd_setImage(with:URL (string: u), placeholderImage:img_default_app)
            }
            
            let qty = "qty".localized
            let size = "sizetext".localized
            
            cell.lbl_order_name.text = model.subcategory_name
            cell.lbl_qty.text = "\(qty) \(model.order_product_qty)"
            cell.lbl_size.text = "\(size) \(model.order_product_size)"
        } else {
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
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        is_details_item = false
    }
    
}





// MARK:- PAYPAL


//var environment:String = PayPalEnvironmentNoNetwork {
//    willSet(newEnvironment) {
//        if (newEnvironment != environment) {
//            PayPalMobile.preconnect(withEnvironment: newEnvironment)
//        }
//    }
//}
//
//
//
//var resultText = "" // empty
//var payPalConfig = PayPalConfiguration() // default
//

extension Order_Details_ViewController {
//    func func_paypal_setup() {
//
//        // Set up payPalConfig
//        payPalConfig.acceptCreditCards = true
//        payPalConfig.merchantName = "Awesome Shirts, Inc."
//        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
//        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
//        payPalConfig.rememberUser = false
//
//        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
//
//        payPalConfig.payPalShippingAddressOption = .payPal;
//
//        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
//
//        payPalConfig.defaultUserEmail = "raja@gmail.com"
//    }
    
    
    // MARK: Single Payment
    func func_pay_with_paypal() {
        // Remove our last completed payment, just for demo purposes.
//        resultText = ""
        
        // Note: For purposes of illustration, this example shows a payment that includes
        //       both payment details (subtotal, shipping, tax) and multiple items.
        //       You would only specify these if appropriate to your situation.
        //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
        //       and simply set payment.amount to your total charge.
        
        var pay_Currency = ""
        if let default_value = UserDefaults.standard.object(forKey: "Currency") as? String {
            pay_Currency = "USD" //default_value.uppercased()
        }
        
//        var items = [PayPalItem]()
//
//        for model in Model_Bag.shared.arr_view_cart {
//            items.append(PayPalItem(name: model.product_name, withQuantity:UInt(model.cart_product_qty)!, withPrice: NSDecimalNumber(string:model.product_price), withCurrency: pay_Currency, withSku: model.product_id))
//        }
        
        //            let item1 = PayPalItem(name: "Old jeans with holes", withQuantity: 2, withPrice: NSDecimalNumber(string: "84.99"), withCurrency: pay_Currency, withSku: "Hip-0037")
        //            let item2 = PayPalItem(name: "Free rainbow patch", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.00"), withCurrency: pay_Currency, withSku: "Hip-00066")
        //            let item3 = PayPalItem(name: "Long-sleeve plaid shirt (mustache not included)", withQuantity: 1, withPrice: NSDecimalNumber(string: "37.99"), withCurrency: pay_Currency, withSku: "Hip-00291")
        
        // Optional: include multiple items
        
        //        let items = [item1, item2, item3]
//        let subtotal = PayPalItem.totalPrice(forItems: items)
//        print(subtotal)
//        // Optional: include payment details
//        let shipping = NSDecimalNumber(string: shipping_cost)
//        let tax = NSDecimalNumber(string: "0")
//        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
//
//        let total = subtotal.adding(shipping).adding(tax)
//        print(total)
//
//        let payment = PayPalPayment(amount: total, currencyCode: pay_Currency, shortDescription: "You need to pay", intent: .sale)
//
//        payment.items = items
//        payment.paymentDetails = paymentDetails
//
//        if (payment.processable) {
//            //            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
//            //            present(paymentViewController!, animated: true, completion: nil)
//        }
//        else {
//            // This particular payment will always be processable. If, for
//            // example, the amount was negative or the shortDescription was
//            // empty, this payment wouldn't be processable, and you'd want
//            // to handle that here.
//            print("Payment not processalbe: \(payment)")
//            
//            let alert = UIAlertController (title:"Payment not processalbe:", message:"\(payment)", preferredStyle: .alert)
//            let yes = UIAlertAction(title: "Ok", style: .default) { (yes) in
//                
//            }
//            
//            alert.addAction(yes)
//            
//            alert.view.tintColor = UIColor .black
//            present(alert, animated: true, completion: nil)
//        }
        
    }
    
    // PayPalPaymentDelegate
//    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
//        print("PayPal Payment Cancelled")
//        resultText = ""
//        //        successView.isHidden = true
//        paymentViewController.dismiss(animated: true, completion: nil)
//    }
    
//    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
//        print("PayPal Payment Success!")
//        paymentViewController.dismiss(animated: true, completion: { () -> Void in
//            // send completed confirmaion to your server
//            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
//
//            let dict_payment_details = completedPayment.confirmation as! [String:Any]
//            //            print(dict_payment_details)
//            let dict_response = dict_payment_details["response"] as! [String:Any]
//            //            print(dict_response)
//            let create_time = "\(dict_response["create_time"] ?? "")"
//            let id = "\(dict_response["id"] ?? "")"
//            let state = "\(dict_response["state"] ?? "")"
//
//            NotificationCenter.default.post(name: NSNotification.Name (rawValue: "paypal_payment"), object: nil)
//
//            //            print(create_time)
//            //            print(id)
//            //            print(state)
//
//            //            self.resultText = completedPayment.description
//            //            self.showSuccess()
//        })
//    }
    
    
    // MARK: Future Payments
    
    @IBAction func authorizeFuturePaymentsAction(_ sender: AnyObject) {
        //        let futurePaymentViewController = PayPalFuturePaymentViewController(configuration: payPalConfig, delegate: self)
        //        present(futurePaymentViewController!, animated: true, completion: nil)
    }
    
//    func payPalFuturePaymentDidCancel(_ futurePaymentViewController: PayPalFuturePaymentViewController) {
//        print("PayPal Future Payment Authorization Canceled")
//        //        successView.isHidden = true
//        futurePaymentViewController.dismiss(animated: true, completion: nil)
//    }
    
//    func payPalFuturePaymentViewController(_ futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [AnyHashable: Any]) {
//        print("PayPal Future Payment Authorization Success!")
//        // send authorization to your server to get refresh token.
//        futurePaymentViewController.dismiss(animated: true, completion: { () -> Void in
//            //            self.resultText = futurePaymentAuthorization.description
//            //            self.showSuccess()
//        })
//    }
    
    // MARK: Profile Sharing
    
//    @IBAction func authorizeProfileSharingAction(_ sender: AnyObject) {
//        let scopes = [kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]
//        //        let profileSharingViewController = PayPalProfileSharingViewController(scopeValues: NSSet(array: scopes) as Set<NSObject>, configuration: payPalConfig, delegate: self)
//        //        present(profileSharingViewController!, animated: true, completion: nil)
//    }
    
    // PayPalProfileSharingDelegate
    
//    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
//        print("PayPal Profile Sharing Authorization Canceled")
//        //        successView.isHidden = true
//        profileSharingViewController.dismiss(animated: true, completion: nil)
//    }
    
//    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable: Any]) {
//        print("PayPal Profile Sharing Authorization Success!")
//        
//        // send authorization to your server
//        
//        profileSharingViewController.dismiss(animated: true, completion: { () -> Void in
//            //            self.resultText = profileSharingAuthorization.description
//            //            self.showSuccess()
//        })
//        
//    }
        
    @IBAction func btn_cancel_order(_ sender:UIButton) {
        let alert = UIAlertController (title: "warning".localized, message: "cancelorder".localized, preferredStyle: .alert)
        let yes = UIAlertAction(title: "yes".localized, style: .default) { (yes) in
            let model = Model_payment_checkout.shared.model_order
            Model_Order.shared.order_items_id = model.order_items_id
            Model_Order.shared.product_id = model.product_id
            
//            if sender.currentTitle?.lowercased() == "cancel" {
                self.func_cancel_order_item()
//            } else {
//                self.func_reason_list()
//            }
        }
        
        let no = UIAlertAction(title: "no".localized, style: .default) { (yes) in
            
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        
        alert.view.tintColor = UIColor .black
        present(alert, animated: true, completion: nil)
    }

    
    
    func func_cancel_order_item() {
        func_ShowHud()
        Model_Order.shared.func_cancel_order_item { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Order.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Order.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()

                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }

}



