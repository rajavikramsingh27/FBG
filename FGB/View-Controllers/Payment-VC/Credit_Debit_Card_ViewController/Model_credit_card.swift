//
//  Model_credit_card.swift
//  FGB
//
//  Created by iOS-Appentus on 16/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class Model_credit_card {
    static let shared = Model_credit_card()
    
    var customer_id = ""
    var card_exp_date = ""
    var card_number = ""
    var card_type = ""
    var card_id = ""
    var str_message = ""
    
    var is_edit = false
    var card_details = Model_payment_methods()
    
    func func_add_card(completionHandler:@escaping (String)->()) {
        let params = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "card_exp_date":card_exp_date,
            "card_number":card_number,
            "card_type":card_type,
            "payment_email":""
        ]
        
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"add_card", parameters: params) {
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
    
    func func_update_card(completionHandler:@escaping (String)->()) {
        let params = [
            "card_id":card_id,
            "card_exp_date":card_exp_date,
            "card_number":card_number,
            "card_type":card_type,
            "payment_email":""
        ]
        
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"update_card", parameters: params) {
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




