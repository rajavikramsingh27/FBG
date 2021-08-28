//
//  Model_payment_checkout.swift
//  FGB
//
//  Created by iOS-Appentus on 18/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class Model_payment_checkout {
    static let shared = Model_payment_checkout()
    
    var payment_type = ""
    var delivery_charges = ""
    
    var fname = ""
    var lname = ""
    var customer_email = ""
    var customer_mobile = ""
    var customer_dob = ""
    var customer_gender = ""
    
    var country = ""
    var taxname = ""
    var tax_rate = ""
    var currency_name = ""
    var currency_price = ""
    
    var delivery_type_id = ""
    var delivery_type = ""
    var delivery_description = ""
    var delivery_type_cost = ""
    var delivery_days = ""
    
    var payment_method_type = ""
    var delivery_address = ""
    var order_amount = ""
    
    var tax_amount = "10"
    var wallet_amount = ""
    var isFROM_WALLET = false
    var order_shipping_note = ""
    var promo_code = ""
    
    var promo_discount = ""
    var transaction_id = ""
    
    var arr_get_delivery_type = [Model_payment_checkout]()
    
    var model_order = Model_Order()
    
    var str_message = ""
    
    func func_update_personal_info(completionHandler:@escaping (String)->()) {
        var currency_id = ""
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            var dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            currency_id = "\(dict_LoginData["currency_id"] ?? "")"
        }
        
        let params = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "fname":fname,
            "lname":lname,
            "customer_email":customer_email,
            "customer_mobile":customer_mobile,
            "customer_dob":customer_dob,
            "customer_gender":customer_gender,
            "currency_id":currency_idd
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"update_personal_info", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                let dict_Result = dict_JSON["result"] as! [String:Any]
                let data_dict_Result = NSKeyedArchiver.archivedData(withRootObject: dict_Result)
                UserDefaults.standard .setValue(data_dict_Result, forKey: "login_Data")
                
                self.str_message = dict_JSON["message"] as! String
                completionHandler(dict_JSON["status"] as! String)
            } else {
                if let str_status = dict_JSON["status"] as? String {
                    if str_status == "failed" {
                        self.str_message = dict_JSON["message"] as! String
                        completionHandler(dict_JSON["status"] as! String)
                    } else {
                        completionHandler("false")
                    }
                } else {
                    completionHandler("false")
                }
            }
        }
    }
    
    func func_get_delivery_type(completionHandler:@escaping (String)->()) {
        let params = [:] as! [String:Any]
        print(params)
        
        APIFunc.getAPI(url: k_base_url+"get_delivery_type", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_delivery_type.removeAll()
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                
                for dict_result in arr_result {
                    self.arr_get_delivery_type.append(self.func_set_delivery_type(dict: dict_result))
                }
                
                completionHandler(dict_JSON["status"] as! String)
            } else {
                if let str_status = dict_JSON["status"] as? String {
                    if str_status == "failed" {
                        self.str_message = dict_JSON["message"] as! String
                        completionHandler(dict_JSON["status"] as! String)
                    } else {
                        completionHandler("false")
                    }
                } else {
                    completionHandler("false")
                }
            }
        }
    }
    
    func func_order_placed(completionHandler:@escaping (String)->()) {
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            country = "\(dict_LoginData["country_name"] ?? "")"
            taxname = "\(dict_LoginData["country_tax_name"] ?? "")"
            tax_rate = "\(dict_LoginData["country_tax"] ?? "")"
            currency_name = "\(dict_LoginData["currency_symbol"] ?? "")"
            currency_price = "\(dict_LoginData["currency_price"] ?? "")"
            
            order_shipping_note = "\(dict_LoginData["shipping_note"] ?? "")"
            wallet_amount  = "\(dict_LoginData["customer_wallet"] ?? "")"
        }
        
        if !isFROM_WALLET {
            wallet_amount = "0"
        }
        
        let params = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "currency_id":currency_idd,
            "delivery_address":delivery_address,
            "payment_method_type":payment_method_type,
            
            "order_amount":order_amount,
            "delivery_type_id":delivery_type_id,
            "delivery_charges":delivery_charges,
            "country":country,
            
            "taxname":taxname,
            "tax_rate":tax_rate,
            "currency_name":currency_name,
            "currency_price":currency_price,
            
            "tax_amount":tax_amount,
            "order_shipping_note":order_shipping_note,
            "wallet_amount":wallet_amount,
            "promo_discount":promo_code_discount,
            "transaction_id":transaction_id
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"order_placed", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                self.str_message = dict_JSON["message"] as! String
                completionHandler(dict_JSON["status"] as! String)
            } else {
                if let str_status = dict_JSON["status"] as? String {
                    if str_status == "failed" {
                        self.str_message = dict_JSON["message"] as! String
                        completionHandler(dict_JSON["status"] as! String)
                    } else {
                        completionHandler("false")
                    }
                } else {
                    completionHandler("false")
                }
            }
        }
    }
    
   private func func_set_delivery_type(dict:[String:Any]) -> Model_payment_checkout {
        let model = Model_payment_checkout()
        
        model.delivery_type_id = "\(dict["delivery_type_id"] ?? "")"
        model.delivery_type = "\(dict["delivery_type"] ?? "")"
        model.delivery_description = "\(dict["delivery_description"] ?? "")"
        model.delivery_type_cost = "\(dict["delivery_type_cost"] ?? "")"
        model.delivery_days = "\(dict["delivery_days"] ?? "")"
        model.country = "\(dict["country"] ?? "")"
    
        return model
    }
    
    var promo_code_id = ""
    var promo_code_title = ""
    var promo_code_start_date = ""
    var promo_code_end_date = ""
    var promo_code_discount = ""
    var city = ""
    var usage_limit = ""
    var promo_code_status = ""
    var latitude = ""
    var longitude = ""
    var radius = ""
    var maximum_discount = ""
    var terms_and_condition = ""
    var mini_amount_to_use = ""
    var promo_code_type = ""
    
    func func_apply_promo_code(completionHandler:@escaping (String)->()) {
        let params = ["promo_code":promo_code] as [String:Any]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"apply_promo_code", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                let dict = dict_JSON["result"] as! [String:Any]
                
                self.promo_code_id = "\(dict["promo_code_id"] ?? "")"
                self.promo_code = "\(dict["promo_code"] ?? "")"
                self.promo_code_title = "\(dict["promo_code_title"] ?? "")"
                self.promo_code_start_date = "\(dict["promo_code_start_date"] ?? "")"
                self.promo_code_end_date = "\(dict["promo_code_end_date"] ?? "")"
                self.promo_code_discount = "\(dict["promo_code_discount"] ?? "")"
                self.city = "\(dict["city"] ?? "")"
                self.usage_limit = "\(dict["usage_limit"] ?? "")"
                self.promo_code_status = "\(dict["promo_code_status"] ?? "")"
                self.latitude = "\(dict["latitude"] ?? "")"
                self.longitude = "\(dict["longitude"] ?? "")"
                self.radius = "\(dict["radius"] ?? "")"
                self.maximum_discount = "\(dict["maximum_discount"] ?? "")"
                self.terms_and_condition = "\(dict["terms_and_condition"] ?? "")"
                self.mini_amount_to_use = "\(dict["mini_amount_to_use"] ?? "")"
                self.promo_code_type = "\(dict["promo_code_type"] ?? "")"
                
                self.str_message = dict_JSON["message"] as! String
                completionHandler(dict_JSON["status"] as! String)
            } else {
                self.promo_code_discount = ""
                if let str_status = dict_JSON["status"] as? String {
                    if str_status == "failed" {
                        self.str_message = dict_JSON["message"] as! String
                        completionHandler(dict_JSON["status"] as! String)
                    } else {
                        completionHandler("false")
                    }
                } else {
                    completionHandler("false")
                }
            }
        }
    }
    
}






