//  Model_payment_methods.swift
//  FGB
//  Created by iOS-Appentus on 16/03/19.
//  Copyright © 2019 appentus. All rights reserved.

import Foundation


class Model_payment_methods {
    static let shared = Model_payment_methods()
    
    var customer_id = ""
    
    var card_id = ""
    var card_number = ""
    var card_exp_date = ""
    var card_type = ""
    var payment_email = ""

    
    var str_message = ""
    
    var arr_view_card = [Model_payment_methods]()
    
    func func_view_card(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id]
        
        APIFunc.postAPI(url: k_base_url+"view_card", parameters:param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_view_card.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_view_card.append(self.func_set_cards(dict: dict))
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
    
    
    func func_remove_card(completionHandler:@escaping (String)->()) {
        let param = ["card_id":card_id]
        
        APIFunc.postAPI(url: k_base_url+"remove_card", parameters:param) {
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
    
    
    private func func_set_cards(dict:[String:Any]) -> Model_payment_methods {
        let model = Model_payment_methods()
        
        model.customer_id = "\(dict["customer_id"] ?? "")"
        
        model.card_id = "\(dict["card_id"] ?? "")"
        model.card_number = "\(dict["card_number"] ?? "")"
        model.card_exp_date = "\(dict["card_exp_date"] ?? "")"
        model.card_exp_date = "\(dict["card_exp_date"] ?? "")"
        model.card_type = "\(dict["card_type"] ?? "")"
        model.payment_email = "\(dict["payment_email"] ?? "")"
        
        return model
    }
    
    
    
}





