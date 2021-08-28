


//
//  Model_FAQFAQ.swift
//  FGB
//
//  Created by appentus on 6/21/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation
class Model_FAQ {
    static let shared = Model_FAQ()
    
    var faq_id = ""
    var faq_title = ""
    var faq_ans = ""
    
    var str_message = ""
    
    var arr_get_faq = [Model_FAQ]()
    
    func func_get_faq(completionHandler:@escaping (String)->()) {
        APIFunc.getAPI(url: k_base_url+"get_faq", parameters: [:]) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_faq.removeAll()
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_faq.append(self.func_set_data(dict: dict))
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
    
    
    private func func_set_data(dict:[String:Any]) -> Model_FAQ {
        let model = Model_FAQ()
        
        model.faq_id = "\(dict["faq_id"] ?? "")"
        model.faq_title = "\(dict["faq_title"] ?? "")"
        model.faq_ans = "\(dict["faq_ans"] ?? "")"
        
        return model
    }
    
    
}


