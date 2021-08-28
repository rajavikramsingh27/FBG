//  Model_Currency.swift
//  FGB
//  Created by iOS-Appentus on 28/03/19.
//  Copyright © 2019 appentus. All rights reserved.


import Foundation


class Model_Currency {
    static let shared = Model_Currency()
    
    var currency_id = ""
    var currency_name = ""
    var currency_symbol = ""
    var currency_price = ""
    
    var str_message = ""
    var arr_get_currency = [Model_Currency]()
    
    func func_get_currency(completionHandler:@escaping (String)->()) {
        APIFunc.getAPI(url: k_base_url+"get_currency", parameters: [:]) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_currency.removeAll()
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_currency.append(self.func_set_data(dict: dict))
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
    
    private func func_set_data(dict:[String:Any]) -> Model_Currency {
        let model = Model_Currency()
        
        model.currency_id = "\(dict["currency_id"] ?? "")"
        model.currency_name = "\(dict["currency_name"] ?? "")"
        model.currency_symbol = "\(dict["currency_symbol"] ?? "")"
        model.currency_price = "\(dict["currency_price"] ?? "1")"
        
        return model
    }
    
    
}


