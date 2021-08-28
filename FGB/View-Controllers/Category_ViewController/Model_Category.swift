//
//  Model_Category.swift
//  FGB
//
//  Created by iOS-Appentus on 14/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation



class Model_Category {
    static let shared = Model_Category()
    
    var collection_code = ""
    var category_id = ""
    var category_code = ""
    var category_icon = ""
    var category_name = ""
    var category_status = ""
    
    var subcate_id = ""
    var subcategory_icon = ""
    var subcategory_name = ""
    var subcategory_code = ""
    var subcategory_status = ""
    
    var str_message = ""
    
    var Subcategory = [Model_Category]()
    var arr_category_subcate = [Model_Category]()
    
    func func_category_subcate(completionHandler:@escaping (String)->()) {
        let param = ["collection_code":collection_code,
                     "page":"1"]
        APIFunc.postAPI(url: k_base_url+"get_category_by_collection", parameters:param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_category_subcate.removeAll()
            if dict_JSON["status"] as? String == "success" {
                if let arr_result = dict_JSON["result"] as? [[String:Any]] {
                    for dict in arr_result {
                        self.arr_category_subcate.append(self.func_set_category_subcate(dict: dict))
                    }
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
    
    private func func_set_category_subcate(dict:[String:Any]) -> Model_Category {
        let model = Model_Category()
        
        model.category_id = "\(dict["category_id"] ?? "")"
        model.category_code = "\(dict["category_code"] ?? "")"
        model.category_icon = "\(dict["category_icon"] ?? "")"
        model.category_name = "\(dict["category_name"] ?? "")"
        model.category_status = "\(dict["category_status"] ?? "")"
        
        if let arr_Subcategory = dict["Subcategory"] as? [[String:Any]] {
            for dict in arr_Subcategory {
                model.Subcategory.append(self.func_set_subcate(dict: dict))
            }
        }
        
        return model
    }
    
     func func_set_subcate(dict:[String:Any]) -> Model_Category {
        let model = Model_Category()
        
        model.category_id = "\(dict["category_id"] ?? "")"
        
        model.subcate_id = "\(dict["subcate_id"] ?? "")"
        model.subcategory_icon = "\(dict["subcategory_icon"] ?? "")"
        model.subcategory_name = "\(dict["subcategory_name"] ?? "")"
        model.subcategory_code = "\(dict["subcategory_code"] ?? "")"
        model.subcategory_status = "\(dict["subcategory_status"] ?? "")"
        
        return model
    }

    
}




