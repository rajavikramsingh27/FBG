//  Model_Sign_Up.swift
//  FGB
//  Created by iOS-Appentus on 13/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import Foundation
import UIKit



class Model_Sign_Up {
    static let shared = Model_Sign_Up()
    
    var fname = ""
    var lname = ""
    var email = ""
    var password = ""
    var device_type = ""
    var social_id = ""
    var device_token = ""
    var customer_profile = UIImage()
    var img_fb_profile = ""
    
    var str_message = ""
    
    func func_customer_signup(completionHandler:@escaping (String)->()) {
        var params = [String:String]()
        
        var data_image = Data()
        
        if customer_profile != nil {
//            data_image = UIImageJPEGRepresentation(customer_profile, 0.2)!
            params = [
                "fname":fname,
                "lname":lname,
                "email":email,
                "password":password,
                "device_type":"2",
                "social_id":social_id,
                "device_token":k_FireBaseFCMToken,
                "customer_profile":""
            ]
        } else {
            params = [
                "fname":fname,
                "lname":lname,
                "email":email,
                "password":password,
                "device_type":"2",
                "social_id":social_id,
                "device_token":k_FireBaseFCMToken,
                "customer_profile":img_fb_profile
            ]
        }
        
        print(params)
        
        APIFunc.func_UploadWithImage(endUrl: k_base_url+"customer_signup", imageData: data_image, parameters: params, img_param: "customer_profile") {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                var dict_Result = dict_JSON["result"] as! [String:Any]
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
    
    
}





