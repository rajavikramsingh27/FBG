//
//  Model_Item_Details.swift
//  FGB
//
//  Created by iOS-Appentus on 14/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation
class Model_Item_Details {
    static let shared = Model_Item_Details()
    
    var page = "1"
    var product_id = ""
    var category_code = ""
    var subcate_code = ""
    var product_name = ""
    var product_price = ""
    var product_image = ""
    var product_description = ""
    var product_qty = ""
    var product_issale = ""
    var product_offer = ""
    var product_isbestseller = ""
    var product_istrend = ""
    var product_status = ""
    var product_adate = ""
    
    var product_sizes = ""
    var product_color = ""
    
    var image_path = ""
    var image_name = ""
    
    var category_id = ""
    var category_icon = ""
    var category_name = ""
    var category_status = ""
    var subcate_id = ""
    var subcategory_icon = ""
    var subcategory_name = ""
    var subcategory_code = ""
    var subcategory_status = ""
    
    var currency_id = ""
    var currency_name = ""
    var currency_symbol = ""
    var currency_price = "1"
    var product_currency_name = ""
    var product_currency_symbol = ""
    var product_currency_price = "1"
    
    var str_message = ""
    
    var arr_get_products = [Model_Item_Details]()
    var arr_Subcategory = [Model_Category]()
    
    var is_get_product_by_category = false
    
    func func_get_products(completionHandler:@escaping (String)->()) {
        var str_URL = ""
        var param = [String:Any]()
        
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            currency_idd = "\(dict_LoginData["currency_id"] ?? "")"
        }
        
        if is_get_product_by_category {
            str_URL = "get_product_by_category"
            param = ["category_code":Model_Category.shared.subcategory_code,
                     "currency_id":currency_idd,
                     "page":page
                    ]
        } else {
            str_URL = "get_products"
            param = ["subcate_code":Model_Category.shared.subcategory_code,
                     "currency_id":currency_idd,
                     "page":page
                    ]
        }
        
        print(param)
        APIFunc.postAPI(url: k_base_url+str_URL, parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
//            self.arr_get_products.removeAll()
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_products.append(self.func_set_data(dict: dict))
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
    
    private func func_set_data(dict:[String:Any]) -> Model_Item_Details {
        let model = Model_Item_Details()
        
        model.product_id = "\(dict["product_id"] ?? "")"
        model.category_code = "\(dict["category_code"] ?? "")"
        model.subcate_code = "\(dict["subcate_code"] ?? "")"
        model.product_name = "\(dict["product_name"] ?? "")"
        model.product_price = "\(dict["product_price"] ?? "")".trimmingCharacters(in: .whitespaces)
        model.product_image = "\(dict["product_image"] ?? "")"
        model.product_description = "\(dict["product_description"] ?? "")"
        model.product_qty = "\(dict["product_qty"] ?? "")"
        model.product_issale = "\(dict["product_issale"] ?? "")"
        model.product_offer = "\(dict["product_offer"] ?? "")"
        model.product_isbestseller = "\(dict["product_isbestseller"] ?? "")"
        model.product_istrend = "\(dict["product_istrend"] ?? "")"
        model.product_status = "\(dict["product_status"] ?? "")"
        model.product_adate = "\(dict["product_adate"] ?? "")"
        
        model.image_path = "\(dict["image_path"] ?? "")"
        model.image_name = "\(dict["image_name"] ?? "")"
        
        model.category_id = "\(dict["category_id"] ?? "")"
        model.category_icon = "\(dict["category_icon"] ?? "")"
        model.category_name = "\(dict["category_name"] ?? "")"
        model.category_status = "\(dict["category_status"] ?? "")"
        model.subcate_id = "\(dict["subcate_id"] ?? "")"
        model.subcategory_icon = "\(dict["subcategory_icon"] ?? "")"
        model.subcategory_name = "\(dict["subcategory_name"] ?? "")"
        model.subcategory_code = "\(dict["subcategory_code"] ?? "")"
        model.subcategory_status = "\(dict["subcategory_status"] ?? "")"
        
        model.currency_id = "\(dict["currency_id"] ?? "")"
        model.currency_name = "\(dict["currency_name"] ?? "")"
        model.currency_symbol = "\(dict["currency_symbol"] ?? "")"
        
        let str_currency_price = "\(dict["currency_price"] ?? "1")"
        if str_currency_price.isEmpty {
            model.currency_price = "1"
        } else {
            model.currency_price = str_currency_price.trimmingCharacters(in: .whitespaces)
        }
        
        model.product_currency_name = "\(dict["product_currency_name"] ?? "")"
        model.product_currency_symbol = "\(dict["product_currency_symbol"] ?? "")"
        model.product_currency_price = "\(dict["product_currency_price"] ?? "")".trimmingCharacters(in: .whitespaces)
        
        return model
    }
    
    
}


