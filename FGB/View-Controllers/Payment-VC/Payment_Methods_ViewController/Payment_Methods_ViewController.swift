//  Payment_Methods_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit
import Braintree
import BraintreeDropIn

var is_add_pay_first = true
var total_pay_product_price = ""

class Payment_Methods_ViewController: UIViewController {
    @IBOutlet weak var btn_COD:UIButton!
    @IBOutlet weak var btn_paypal:UIButton!
    
    @IBOutlet weak var nav_bar:UINavigationBar!
    
    @IBOutlet weak var view_paypal:UIView!
    @IBOutlet weak var view_cod:UIView!
    
    @IBOutlet weak var height_cod:NSLayoutConstraint!
    @IBOutlet weak var top_cod:NSLayoutConstraint!
    @IBOutlet weak var bottom_cod:NSLayoutConstraint!
    
//    var shipping_cost = "0"
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    var currency = ""
    var first_name = ""
    var email = ""
    
    var token = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_COD.setTitle("cash_on_delivery".localized, for: .normal)
        btn_paypal.setTitle("Pay Using Card".localized, for: .normal)
        
        nav_bar.topItem?.title = "PaymentMethod".localized
                
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            currency = "\(dict_LoginData["currency_symbol"] ?? "")"
            first_name = "\(dict_LoginData["customer_fname"] ?? "")"
            email = "\(dict_LoginData["customer_email"] ?? "")"
            
            let country_name = "\(dict_LoginData["country_name"] ?? "")"
            if country_name.contains("Saudi Arabia") {
                height_cod.constant = 80
                top_cod.constant = 30
//                bottom_cod.constant = 30
                
                view_cod.isHidden = false
            } else {
                height_cod.constant = 0
                top_cod.constant = 0
//                bottom_cod.constant = 0
                
                view_cod.isHidden = true
            }
        }
        
        nav_bar.applyNavGradient()
//        func_paypal_setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        is_add_pay_first = false
//        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_COD(_ sender:Any) {
        Model_payment_checkout.shared.payment_method_type = "COD"
        func_paypal_payment()
    }
    
    @IBAction func btn_paypal(_ sender:Any) {
//        Model_payment_checkout.shared.payment_method_type = "PayPal"
        
        total_pay_product_price = engish_digits(total_pay_product_price)
        
        if Double(total_pay_product_price)! == 0 {
            func_paypal_payment()
        } else {
            Model_PaymentMethod.shared.first_name = first_name
            Model_PaymentMethod.shared.email = email
            Model_PaymentMethod.shared.amount = total_pay_product_price
            Model_PaymentMethod.shared.currency = currency
            
            func_ShowHud()
            Model_PaymentMethod.shared.func_charges { (url) in
                DispatchQueue.main.async {
                    self.func_HideHud()
                    
                    if url != "failure" {
                        let payment_method_VC = self.storyboard?.instantiateViewController(withIdentifier:"Payment_Method_WebView_VC") as! Payment_Method_WebView_VC
                        payment_method_VC.str_URL_PaymentMethod = url
                        self.present(payment_method_VC, animated: true, completion: nil)
                    } else {
                        self.func_ShowHud_Error(with: "Payment failure")
                        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                            self.func_HideHud()
                        })
                    }
                }
            }
//            func_pay_with_paypal()
//            paypal_sdk_brqiantree()
        }
        
    }
    
    func func_paypal_payment() {
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "payment_success"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    func paypal_sdk_brqiantree(){
//        generate_token(param: ["":""]) { (resp) in
//            self.token = resp
//            self.showDropIn(clientTokenOrTokenizationKey:  self.token)
//        }
//
//        
//
//
//    }
//    func showDropIn(clientTokenOrTokenizationKey: String) {
//
//        let request =  BTDropInRequest()
//
//        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
//
//        { (controller, result, error) in
//
//            if (error != nil) {
//
//                print("ERROR")
//
//            } else if (result?.isCancelled == true) {
//
//                print("CANCELLED")
//
//            } else if let result = result {
//
//                //Save Nounce and call api provide by your backend passing amount and nounce string (nounce strin can be get from result.paymentMethod?.nounce)
//
//                self.apply_for_pay(param: ["NONCE":"\(result.paymentMethod?.nonce)","amount":"0.5"])
//            }
//
//            controller.dismiss(animated: true, completion: nil)
//
//        }
//
//        self.present(dropIn!, animated: true, completion: nil)
//
//    }
    
//    func apply_for_pay(param : [String:Any]){
//        func_ShowHud()
//        APIFunc.postAPI(url: k_base_url+"genrate_token", parameters: param) { (response) in
//            if let error = response["error"] as? Bool{
//                self.func_HideHud()
//                self.func_ShowHud_Error(with: "Something went wrong. Please try again!")
//            }else{
//                self.func_HideHud()
//
//
////                completion("\(response["token"]!)")
//            }
//        }
//    }
    
    
//    func generate_token(param : [String:Any], completion : @escaping (String)->()){
//        func_ShowHud()
//        APIFunc.postAPI(url: k_base_url+"genrate_token_ios", parameters: param) { (response) in
//            if let error = response["error"] as? Bool{
//                self.func_HideHud()
//                self.func_ShowHud_Error(with: "Something went wrong. Please try again!")
//            }else{
//                self.func_HideHud()
//                completion("\(response["token"]!)")
//            }
//        }
//    }
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
//var resultText = "" // empty
//var payPalConfig = PayPalConfiguration() // default
//


extension Payment_Methods_ViewController {
//    func func_paypal_setup() {
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
////        payPalConfig.defaultUserEmail = "raja@gmail.com"
//    }
//
    
    
    // MARK: Single Payment
    func func_pay_with_paypal() {
        // Remove our last completed payment, just for demo purposes.
//        resultText = ""
        
        // Note: For purposes of illustration, this example shows a payment that includes
        //       both payment details (subtotal, shipping, tax) and multiple items.
        //       You would only specify these if appropriate to your situation.
        //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
        //       and simply set payment.amount to your total charge.
        
        var pay_Currency = "USD"
        if let default_value = UserDefaults.standard.object(forKey: "Currency") as? String {
            pay_Currency = "USD" //default_value.uppercased()
        }
        
//        var items = [PayPalItem]()
        
        var str_product_name = ""
        for model in Model_Bag.shared.arr_view_cart {
            str_product_name = "\(str_product_name),\(model.product_name)"
        }
//
//        items.append(PayPalItem(name:str_product_name, withQuantity:1, withPrice: NSDecimalNumber(string:total_pay_product_price), withCurrency: pay_Currency, withSku: "FGB_Shopping"))
//
//        let subtotal = PayPalItem.totalPrice(forItems: items)
//        let shipping = NSDecimalNumber(string: "0")
//        let tax = NSDecimalNumber(string: "0")
//        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: 0, withTax:0)
//
//        let total = subtotal.adding(shipping).adding(tax)
//
//        let payment = PayPalPayment(amount:total, currencyCode: pay_Currency, shortDescription: "You need to pay", intent: .sale)
//
//        payment.items = items
//        payment.paymentDetails = paymentDetails
//
        model_paypal_pay_detail.shared.price = "\(total_pay_product_price)"
        model_paypal_pay_detail.shared.currency = "\(pay_Currency)"
        
        let paymentViewController = self.storyboard?.instantiateViewController(withIdentifier: "paypal_web_VC") as! paypal_web_VC
        self.present(paymentViewController, animated: true, completion: nil)
    }
    
//    // PayPalPaymentDelegate
//    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
//        print("PayPal Payment Cancelled")
//        resultText = ""
////        successView.isHidden = true
//        paymentViewController.dismiss(animated: true, completion: nil)
//    }
////
//    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
//        print("PayPal Payment Success!")
//        self.presentingViewController!.dismiss(animated: true, completion: { () -> Void in
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
//            Model_payment_checkout.shared.transaction_id = id
//
////            self.dismiss(animated:true, completion: nil)
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
//
    
    
    // MARK: Future Payments
    
//    @IBAction func authorizeFuturePaymentsAction(_ sender: AnyObject) {
//        //        let futurePaymentViewController = PayPalFuturePaymentViewController(configuration: payPalConfig, delegate: self)
//        //        present(futurePaymentViewController!, animated: true, completion: nil)
//    }
//
//    func payPalFuturePaymentDidCancel(_ futurePaymentViewController: PayPalFuturePaymentViewController) {
//        print("PayPal Future Payment Authorization Canceled")
//        //        successView.isHidden = true
//        futurePaymentViewController.dismiss(animated: true, completion: nil)
//    }
//
//    func payPalFuturePaymentViewController(_ futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [AnyHashable: Any]) {
//        print("PayPal Future Payment Authorization Success!")
//        // send authorization to your server to get refresh token.
//        futurePaymentViewController.dismiss(animated: true, completion: { () -> Void in
//            //            self.resultText = futurePaymentAuthorization.description
//            //            self.showSuccess()
//        })
//    }
//
//    // MARK: Profile Sharing
//
//    @IBAction func authorizeProfileSharingAction(_ sender: AnyObject) {
//        let scopes = [kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]
//        //        let profileSharingViewController = PayPalProfileSharingViewController(scopeValues: NSSet(array: scopes) as Set<NSObject>, configuration: payPalConfig, delegate: self)
//        //        present(profileSharingViewController!, animated: true, completion: nil)
//    }
    
    // PayPalProfileSharingDelegate
//
//    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
//        print("PayPal Profile Sharing Authorization Canceled")
//        //        successView.isHidden = true
//        profileSharingViewController.dismiss(animated: true, completion: nil)
//    }
//
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
//
    func engish_digits(_ num:String) ->String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "EN")
        if let finalText = numberFormatter.number(from: num)
        {
            print("Final text is: ", finalText)
            
            return "\(finalText)"
        } else {
            return "0"
        }

        
//        let number = NSNumber(value: Double(num)!)
//        let format = NumberFormatter()
//        format.maximumFractionDigits = 2
//        format.locale = Locale(identifier: "EN")
//        let faNumber = format.string(from: number)
//        print("arabic no.:- ",faNumber)
//
//        return faNumber!
    }
    
}




