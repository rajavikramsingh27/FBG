

//
//  Model_Tabbar.swift
//  FGB
//
//  Created by iOS-Appentus on 10/04/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation


class Model_Tabbar {
    static let shared = Model_Tabbar()
    
    var message = ""
    var customer_password = ""
    var customer_device_token = ""
    var cart_item = ""
    
    var arr_view_cart = [[String:Any]]()
    
    func func_view_cart(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id,
                     "currency_id":currency_idd
                    ]
        
        APIFunc.postAPI(url: k_base_url+"view_cart", parameters: param) {
            (dict_JSON) in
//            print(dict_JSON)
            
            self.arr_view_cart.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                self.arr_view_cart = dict_JSON["result"] as! [[String:Any]]
                completionHandler(dict_JSON["status"] as! String)
            } else {
                if let str_status = dict_JSON["status"] as? String {
                    if str_status == "failed" {
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
    
    func func_is_user_active(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id]
        
        APIFunc.postAPI(url: k_base_url+"is_user_active", parameters: param) {
            (dict_JSON) in
//            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                let dict_result = dict_JSON["result"] as! [String:Any]
                self.message = "\(dict_JSON["message"] ?? "")"
                self.customer_password = "\(dict_result["customer_password"] ?? "")"
                self.customer_device_token = "\(dict_result["customer_device_token"] ?? "")"
                self.cart_item = "\(dict_result["cart_item"] ?? "")"
                
                UserDefaults.standard.set("\(dict_result["sizes_type"] ?? "")", forKey: "Sizes")
                UserDefaults.standard.set("\(dict_result["collection_type"] ?? "")", forKey: "Collection")
                
                currency_symbol = "\(dict_result["currency_symbol"] ?? "")"
                currency_price = "\(dict_result["currency_price"] ?? "")"
                currency_idd = "\(dict_result["currency_id"] ?? "")"
                
                let data_dict_Result = NSKeyedArchiver.archivedData(withRootObject: dict_result)
                UserDefaults .standard .setValue(data_dict_Result, forKey: "login_Data")
                
                completionHandler(dict_JSON["status"] as! String)
            } else {
                if let str_status = dict_JSON["status"] as? String {
                    if str_status == "failed" {
                        self.message = "\(dict_JSON["message"] ?? "")"
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

