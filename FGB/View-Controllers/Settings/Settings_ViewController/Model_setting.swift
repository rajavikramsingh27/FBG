//
//  Model_setting.swift
//  FGB
//
//  Created by iOS-Appentus on 20/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class Model_setting {
    static let shared = Model_setting()
    
    var customer_currency = ""
    var customer_currency_name = ""
    var country_name = ""
    var currency_prices = ""
    
    var collection_type = ""
    var sizes_type = ""
    var str_message = ""
    
    func func_update_setting(completionHandler:@escaping (String)->()) {
        if let default_value = UserDefaults.standard.object(forKey: "Sizes") as? String {
            sizes_type = default_value.lowercased()
        }
        
        if let default_value = UserDefaults.standard.object(forKey: "Collection") as? String {
            collection_type = default_value.lowercased()
        }
                    
        let param = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "customer_currency":customer_currency,
            "collection_type":collection_type,
            "sizes_type":sizes_type
        ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"update_setting", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
                    var dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
//                    print(dict_LoginData)
                    
                    dict_LoginData["sizes_type"] = self.sizes_type
                    dict_LoginData["collection_type"] = self.collection_type
                    
//                    dict_LoginData["customer_currency"] = self.customer_currency
//                    dict_LoginData["currency_symbol"] = self.customer_currency_name
//                    dict_LoginData["currency_id"] = self.customer_currency
//                    dict_LoginData["currency_name"] = self.customer_currency_name
//                    dict_LoginData["currency_price"] = self.currency_prices
//                    
//                    currency_symbol = self.customer_currency_name
//                    currency_price = self.currency_prices
//                    currency_idd = self.customer_currency
                    
                    let data_dict_Result = NSKeyedArchiver.archivedData(withRootObject: dict_LoginData)
                    UserDefaults .standard .setValue(data_dict_Result, forKey: "login_Data")
                }
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

    
    
    func func_delete_account(completionHandler:@escaping (String)->()) {
        let param = [
            "customer_id":Model_Walk_Through.shared.customer_id
        ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"delete_account", parameters: param) {
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









