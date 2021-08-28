//
//  Model_ProductsShop.swift
//  FGB
//
//  Created by iOS-Appentus on 14/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class Model_Products {
    static let shared = Model_Products()
    
    var recently_view_id = ""

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
    
    var str_message = ""
    
    var arr_get_home_product = [Model_Products]()
    var arr_get_recent = [Model_Products]()
    var arr_get_bestseller = [Model_Products]()
    var arr_get_new = [Model_Products]()
    
    
    func func_get_home_product(completionHandler:@escaping (String)->()) {
        let param = ["product_type":"1"]
        
        APIFunc.postAPI(url: k_base_url+"get_home_product", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_home_product.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                if let arr_result = dict_JSON["result"] as? [[String:Any]] {
                    for dict in arr_result {
                        self.arr_get_home_product.append(self.func_get_home_product(dict: dict))
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
    
    func func_get_recent(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id]
        
        APIFunc.postAPI(url: k_base_url+"get_recent", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_recent.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_recent.append(self.func_get_home_product(dict: dict))
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

    private func func_get_home_product(dict:[String:Any]) -> Model_Products {
        let model = Model_Products()
        
        model.recently_view_id = "\(dict["recently_view_id"] ?? "")"
        
        model.product_id = "\(dict["product_id"] ?? "")"
        model.category_code = "\(dict["category_code"] ?? "")"
        model.subcate_code = "\(dict["subcate_code"] ?? "")"
        model.product_name = "\(dict["product_name"] ?? "")"
        model.product_price = "\(dict["product_price"] ?? "")"
        model.product_image = "\(dict["product_image"] ?? "")"
        model.product_description = "\(dict["product_description"] ?? "")"
        model.product_qty = "\(dict["product_qty"] ?? "")"
        model.product_issale = "\(dict["product_issale"] ?? "")"
        model.product_offer = "\(dict["product_offer"] ?? "")"
        model.product_isbestseller = "\(dict["product_isbestseller"] ?? "")"
        model.product_istrend = "\(dict["product_istrend"] ?? "")"
        model.product_status = "\(dict["product_status"] ?? "")"
        model.product_adate = "\(dict["product_adate"] ?? "")"
        
        model.product_sizes = "\(dict["product_sizes"] ?? "")"
        model.product_color = "\(dict["product_color"] ?? "")"
        
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
        
        return model
    }
    
    var Subcategory = [Model_Category]()
    var arr_category_subcate = [Model_Category]()
    
    func func_category_subcate(completionHandler:@escaping (String)->()) {
        APIFunc.getAPI(url: k_base_url+"category_subcate", parameters: [:]) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_category_subcate.removeAll()
            if dict_JSON["status"] as? String == "success" {
                
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_category_subcate.append(self.func_set_category_subcate(dict: dict))
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
    
    func func_get_bestseller(completionHandler:@escaping (String)->()) {
        let params = ["type":"1"]
        APIFunc.postAPI(url: k_base_url+"get_bestseller_or_new", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_bestseller.removeAll()
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_bestseller.append(self.func_get_home_product(dict: dict))
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

    func func_get_new(completionHandler:@escaping (String)->()) {
        let params = ["type":"2"]
        APIFunc.postAPI(url: k_base_url+"get_bestseller_or_new", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_new.removeAll()
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_new.append(self.func_get_home_product(dict: dict))
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


