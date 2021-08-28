//
//  Model_CountryCountry.swift
//  FGB
//
//  Created by iOS-Appentus on 28/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class Model_Country {
    static let shared = Model_Country()
    
    var currency = ""
    var country_id = ""
    var country_name = ""
    var country_tax = ""
    var country_tax_name = ""
    
    var str_message = ""
    var arr_get_country = [Model_Country]()
    
    func func_get_country(completionHandler:@escaping (String)->()) {
        APIFunc.getAPI(url: k_base_url+"get_country", parameters: [:]) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_country.removeAll()
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_country.append(self.func_set_data(dict: dict))
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
    
    func func_update_contry(completionHandler:@escaping (String)->()) {
        let param = [
            "country":country_id,
            "currency":currency,
            "customer_id":Model_Walk_Through.shared.customer_id
        ]
        
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"update_contry", parameters: param) {
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
    
    private func func_set_data(dict:[String:Any]) -> Model_Country {
        let model = Model_Country()
        
        model.country_id = "\(dict["country_id"] ?? "")"
        model.country_name = "\(dict["country_name"] ?? "")"
        model.country_tax = "\(dict["country_tax"] ?? "")"
        model.country_tax_name = "\(dict["country_tax_name"] ?? "")"
        
        return model
    }
    
    
}


