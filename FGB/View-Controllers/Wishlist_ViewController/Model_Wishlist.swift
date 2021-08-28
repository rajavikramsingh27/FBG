//
//  Model_Wishlist.swift
//  FGB
//
//  Created by iOS-Appentus on 14/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class Model_Wishlist {
    static let shared = Model_Wishlist()
    
    var wishlist_id = ""
    var wishlist_customer_id = ""
    var wishlist_product_id = ""
    var wishlist_adate = ""
    
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
    var inwishlist = ""
    
    var currency_id = ""
    var currency_name = ""
    var currency_symbol = ""
    var currency_price = ""
    var product_currency_name = ""
    var product_currency_symbol = ""
    var product_currency_price = ""
    
    var page = "1"
    var str_message = ""
    
    var arr_get_wish_list = [Model_Wishlist]()
    var arr_get_recent = [Model_Wishlist]()
    
    func func_get_wish_list(completionHandler:@escaping (String)->()) {
        let param = [
                "customer_id":Model_Walk_Through.shared.customer_id,
                "currency_id":currency_idd,
                "page":page
            ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"get_wish_list", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
//            self.arr_get_wish_list.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_wish_list.append(self.func_get_wishlist(dict: dict))
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

    
    func func_add_to_wishlist(completionHandler:@escaping (String)->()) {
        let param = [
            "product_id":Model_Products.shared.product_id,
            "customer_id":Model_Walk_Through.shared.customer_id,
        ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"add_to_wishlist", parameters: param) {
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
    
    func func_remove_to_wishlist_product(completionHandler:@escaping (String)->()) {
        let param = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "product_id":product_id
        ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"remove_to_wishlist_product", parameters: param) {
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
    
    func func_get_recent(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id]
        
        APIFunc.postAPI(url: k_base_url+"get_recent", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_recent.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_get_recent.append(self.func_get_wishlist(dict: dict))
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
    
    
    private func func_get_wishlist(dict:[String:Any]) -> Model_Wishlist {
        print(dict)
        
        let model = Model_Wishlist()
        
        model.wishlist_id = "\(dict["wishlist_id"] ?? "")"
        model.wishlist_customer_id = "\(dict["wishlist_customer_id"] ?? "")"
        model.wishlist_product_id = "\(dict["wishlist_product_id"] ?? "")"
        model.wishlist_adate = "\(dict["wishlist_adate"] ?? "")"
        
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



