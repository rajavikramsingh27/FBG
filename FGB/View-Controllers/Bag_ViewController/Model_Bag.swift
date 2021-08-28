//
//  Model_Bag.swift
//  FGB
//
//  Created by iOS-Appentus on 15/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation



class Model_Bag {
    static let shared = Model_Bag()
    
    var cart_id = ""
    var cart_customer_id = ""
    var cart_product_id = ""
    var cart_product_qty = "0"
    var cart_product_size = ""
    var cart_adate = ""
    
    var product_id = ""
    var category_code = ""
    var subcate_code = ""
    var product_name = ""
    var product_price = "0"
    var product_image = ""
    var product_description = ""
    var product_qty = ""
    var product_issale = ""
    var product_offer = ""
    var product_isbestseller = ""
    var product_istrend = ""
    var product_status = ""
    var product_adate = ""
    
    var image_path = ""
    var image_name = ""

    var product_sizes = ""
    var product_color = ""
    
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
    
    var arr_view_cart = [Model_Bag]()
    
    func func_view_cart(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id,
                     "currency_id":currency_idd
                    ]
        
        APIFunc.postAPI(url: k_base_url+"view_cart", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_view_cart.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_view_cart.append(self.func_get_home_product(dict: dict))
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
    
    func func_remove_to_cart(completionHandler:@escaping (String)->()) {
        let param = ["cart_id":cart_id]
        
        APIFunc.postAPI(url: k_base_url+"remove_to_cart", parameters: param) {
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
    
    func func_update_cart(completionHandler:@escaping (String)->()) {
        let param = [
                    "customer_id":Model_Walk_Through.shared.customer_id,
                    "cart_id":cart_id,
                    "product_size":cart_product_size,
                    "product_qty":cart_product_qty,
                    "product_id":product_id
            ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"update_cart", parameters: param) {
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

    
    
    private func func_get_home_product(dict:[String:Any]) -> Model_Bag {
        let model = Model_Bag()
        
        model.cart_id = "\(dict["cart_id"] ?? "")"
        model.cart_customer_id = "\(dict["cart_customer_id"] ?? "")"
        model.cart_product_id = "\(dict["cart_product_id"] ?? "")"
        model.cart_product_qty = "\(dict["cart_product_qty"] ?? "")"
        model.cart_product_size = "\(dict["cart_product_size"] ?? "")"
        model.cart_adate = "\(dict["cart_adate"] ?? "")"
        
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
        
        model.image_path = "\(dict["image_path"] ?? "")"
        model.image_name = "\(dict["image_name"] ?? "")"

        model.product_sizes = "\(dict["product_sizes"] ?? "")"
        model.product_color = "\(dict["product_color"] ?? "")"
        
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
            model.currency_price = str_currency_price
        }
        
        model.product_currency_name = "\(dict["product_currency_name"] ?? "")"
        model.product_currency_symbol = "\(dict["product_currency_symbol"] ?? "")"
        model.product_currency_price = "\(dict["product_currency_price"] ?? "1")"
        
        return model
    }
    
    
}






