//
//  Model_Login.swift
//  FGB
//
//  Created by iOS-Appentus on 13/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class Model_Login {
    static let shared = Model_Login()
    
    var email = ""
    var password = ""
    var device_type = ""
    var device_token = ""
    var social = ""
    
    var str_message = ""
    
    func func_login(completionHandler:@escaping (String)->()) {
        let params = [
            "email":email,
            "password":password,
            "device_type":"2",
            "device_token":k_FireBaseFCMToken
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"login", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                let dict_Result = dict_JSON["result"] as! [String:Any]
                
                Model_Walk_Through.shared.customer_id = "\(dict_Result["customer_id"] ?? "")"
                Model_Walk_Through.shared.customer_password = "\(dict_Result["customer_password"] ?? "")"
                
                Model_Walk_Through.shared.customer_social_id = "\(dict_Result["customer_social_id"] ?? "")"
                
                currency_symbol = "\(dict_Result["currency_symbol"] ?? "")"
                currency_price = "\(dict_Result["currency_price"] ?? "")"
                currency_idd = "\(dict_Result["currency_id"] ?? "")"
                
                let data_dict_Result = NSKeyedArchiver.archivedData(withRootObject: dict_Result)
                UserDefaults .standard .setValue(data_dict_Result, forKey: "login_Data")
                
                UserDefaults.standard.set(self.password, forKey: "password")
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
    
    
    func func_do_social_login(completionHandler:@escaping (String)->()) {
        let params = [
            "social_id":social,
            "device_type":"2",
            "device_token":k_FireBaseFCMToken
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"do_social_login", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                let dict_Result = dict_JSON["result"] as! [String:Any]
                Model_Walk_Through.shared.customer_id = "\(dict_Result["customer_id"] ?? "")"
                Model_Walk_Through.shared.customer_password = "\(dict_Result["customer_password"] ?? "")"
                Model_Walk_Through.shared.customer_social_id = "\(dict_Result["customer_social_id"] ?? "")"
                
                currency_symbol = "\(dict_Result["currency_symbol"] ?? "")"
                currency_price = "\(dict_Result["currency_price"] ?? "")"
                currency_idd = "\(dict_Result["currency_id"] ?? "")"
                
                let data_dict_Result = NSKeyedArchiver.archivedData(withRootObject: dict_Result)
                UserDefaults .standard .setValue(data_dict_Result, forKey: "login_Data")
                
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
    
    func func_forget_password(completionHandler:@escaping (String)->()) {
        let params = [
            "email":email
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"forget_password", parameters: params) {
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
    
    
}





