//
//  Model_personal_info.swift
//  FGB
//
//  Created by iOS-Appentus on 18/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation


class Model_personal_info {
    static let shared = Model_personal_info()
    
    var fname = ""
    var lname = ""
    var customer_email = ""
    var customer_mobile = ""
    var customer_dob = ""
    var customer_gender = ""
    
    var str_message = ""
    
    func func_update_personal_info(completionHandler:@escaping (String)->()) {
        let params = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "fname":fname,
            "lname":lname,
            "customer_email":customer_email,
            "customer_mobile":customer_mobile,
            "customer_dob":customer_dob,
            "customer_gender":customer_gender
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
    
    
}




