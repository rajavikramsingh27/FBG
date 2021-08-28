//  Model_PaymentMethodPaymentMethod.swift
//  FGB
//  Created by appentus technologies pvt. ltd. on 9/21/19.
//  Copyright © 2019 appentus. All rights reserved.


import Foundation


class Model_PaymentMethod {
    static let shared = Model_PaymentMethod()
    
    var email = ""
    var amount = ""
    var currency = ""
    var first_name = ""
    
    var str_message = ""
    
    
    
    func func_PARAM() -> String {
        let receipt = ["email":false,"sms":true]
        let customer = ["first_name":first_name,"email":email]
        let source = ["id":"src_card"]
        let post = ["url":"http://appentus.me/FGB/payment/success.php"]
        let redirect = ["url":"http://appentus.me/FGB/payment/success.php"]
        
        let param = ["amount":amount,"currency":currency,"threeDSecure":true,"save_card":false,"receipt":receipt,"customer":customer,"source":source,"post":post,"redirect":redirect] as [String : Any]
        
        let dict = param
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options:.prettyPrinted)
        return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    func func_DictToString(_ dict:[String:Any]) -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options:.prettyPrinted)
        return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    func func_charges(completionHandler:@escaping (String)->()) {
          let receipt = ["email":false,"sms":true]
          let customer = ["first_name":first_name,"email":email]
          let source = ["id":"src_card"]
          let post = ["url":"http://appentus.me/FGB/payment/success.php"]
          let redirect = ["url":"http://appentus.me/FGB/payment/success.php"]
        
        let param = ["amount":amount,"currency":currency,"threeDSecure":true,"save_card":false,"receipt":receipt,"customer":customer,"source":source,"post":post,"redirect":redirect] as [String : Any]
        let dict = param
        print(dict)
        
        APIFunc.func_Payment(url:"https://api.tap.company/v2/charges", requestParams: dict) {
            (dict_JSON) in
            print(dict_JSON)
            
            if let dict_transaction = dict_JSON["transaction"] as? [String:Any] {
                if let url = dict_transaction["url"] as? String {
                    completionHandler("\(url)")
                } else {
                    completionHandler("failure")
                }
            } else {
                completionHandler("failure")
            }
        }
    }
    
}


