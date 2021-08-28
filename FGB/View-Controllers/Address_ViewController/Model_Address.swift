//  Model_Address.swift
//  FGB
//  Created by iOS-Appentus on 18/03/19.
//  Copyright © 2019 appentus. All rights reserved.


import Foundation


class Model_Address {
    static let shared = Model_Address()
    
    var country_name = ""
    
    var customer_country = ""
    var customer_address = ""
    var customer_city = ""
    var customer_postcode = ""
    
    var shipping_state = ""
    var shipping_mobile = ""
    var shipping_country_code = ""
    var shipping_address2 = ""
    var shipping_name = ""
    
    var shipping_note = ""
    
    var str_message = ""
    
    var mobile = ""
    var country_code = ""

    func func_update_address(completionHandler:@escaping (String)->()) {
        let params = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "customer_country":customer_country,
            "customer_address":customer_address,
            "customer_city":customer_city,
            
            "customer_postcode":customer_postcode,
            "shipping_state":shipping_state,
            "shipping_mobile":shipping_mobile,
            "shipping_address2":shipping_address2,
            "shipping_name":shipping_name,
            "shipping_note":shipping_note
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"update_address", parameters: params) {
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
    
    func func_get_customer_address(completionHandler:@escaping (String)->()) {
        let params = [
            "customer_id":Model_Walk_Through.shared.customer_id
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"get_customer_address", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                let dict_result = dict_JSON["result"] as! [String:Any]
                self.str_message = dict_JSON["message"] as! String
                
                self.customer_country = "\(dict_result["customer_country"] ?? "")"
                self.customer_address = "\(dict_result["customer_address1"] ?? "")"
                self.customer_city = "\(dict_result["customer_city"] ?? "")"
                self.customer_postcode = "\(dict_result["customer_postcode"] ?? "")"
                self.country_name = "\(dict_result["country_name"] ?? "")"
                
                self.customer_address = "\(dict_result["shipping_address1"] ?? "")"
                self.shipping_address2 = "\(dict_result["shipping_address2"] ?? "")"
                self.shipping_name = "\(dict_result["shipping_name"] ?? "")"
                self.shipping_state = "\(dict_result["shipping_state"] ?? "")"
                self.customer_city = "\(dict_result["shipping_city"] ?? "")"
                self.shipping_note = "\(dict_result["shipping_note"] ?? "")"
                
                let mobile = "\(dict_result["shipping_mobile"] ?? "")"
                let arr_mobile = mobile.components(separatedBy: "-")
                
                if arr_mobile.count > 0 {
                    self.shipping_country_code  = arr_mobile[0]
                }
                
                if arr_mobile.count > 1 {
                    self.shipping_mobile = arr_mobile[1]
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
    
    
    
    func func_send_otp(completionHandler:@escaping (String)->()) {
        let params = [
            "mobile":mobile,
            "country_code":country_code
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"send_otp", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                self.str_message = "\(dict_JSON["result"] ?? "" )"
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
    
    
}



