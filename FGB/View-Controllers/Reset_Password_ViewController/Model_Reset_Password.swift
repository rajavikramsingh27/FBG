
//  Model_Reset_Password.swift
//  FGB
//  Created by iOS-Appentus on 10/04/19.
//  Copyright © 2019 appentus. All rights reserved.

import Foundation

class Model_Reset_Password {
    static let shared = Model_Reset_Password()
    
    var str_message = ""
    
    var old_password = ""
    var new_password = ""
    
    func func_reset_password(completionHandler:@escaping (String)->()) {
        let params = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "old_password":old_password,
            "new_password":new_password
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"reset_password", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
                    var dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
                    dict_LoginData["customer_password"] = "\(dict_JSON["password"]!)"
                    
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
    
    
}




