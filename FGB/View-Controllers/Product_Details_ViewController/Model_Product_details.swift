//
//  Model_Product_detailsProduct_details.swift
//  FGB
//
//  Created by iOS-Appentus on 14/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation


class Model_Product_details {
    static let shared = Model_Product_details()
    
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
    
    var product_material = ""
    var product_season = ""
    var poduct_origin = ""
    var product_is_washing = ""
    
    var product_image_id = ""
    var image_path = ""
    var image_name = ""
    
    var product_images = [Model_Product_details]()
    
    var product_size = ""
    var product_sizes = ""
    var product_color = ""
    var delivery_days = ""
    
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
    var isrecent = ""
    var cart_id = ""
    var isbag = ""
    
    var related_products = [Model_Product_details]()
    var arr_get_wish_list = [Model_Wishlist]()
    
    var delivery_type_id = ""
    var delivery_type = ""
    var delivery_description = ""
    var delivery_type_cost = ""
    
    var arr_delivery_type = [Model_Product_details]()
        
    var str_message = ""
    
    var currency_id = ""
    var currency_name = ""
    var currency_symbol = ""
    var currency_price = "1"
    var product_currency_name = ""
    var product_currency_symbol = ""
    var product_currency_price = "1"
    
    var product_size_guide_id = ""
    
    func func_get_product_details(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id,
                    "product_id":Model_Products.shared.product_id,
                    "category_code":Model_Products.shared.category_code,
                    "currency_id":currency_idd
            ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"get_product_details", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.related_products.removeAll()
            self.product_images.removeAll()
            self.arr_delivery_type.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                self.func_get_product_details(dict: dict_JSON["result"] as! [String:Any])
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
    
    private func func_get_product_details(dict:[String:Any]) {//} -> Model_Product_details {
        self.product_id = "\(dict["product_id"] ?? "")"
        self.category_code = "\(dict["category_code"] ?? "")"
        self.subcate_code = "\(dict["subcate_code"] ?? "")"
        self.product_name = "\(dict["product_name"] ?? "")"
        self.product_price = "\(dict["product_price"] ?? "")"
        self.product_image = "\(dict["product_image"] ?? "")"
        self.product_description = "\(dict["product_description"] ?? "")"
        self.product_qty = "\(dict["product_qty"] ?? "")"
        self.product_issale = "\(dict["product_issale"] ?? "")"
        self.product_offer = "\(dict["product_offer"] ?? "")"
        self.product_isbestseller = "\(dict["product_isbestseller"] ?? "")"
        self.product_istrend = "\(dict["product_istrend"] ?? "")"
        self.product_status = "\(dict["product_status"] ?? "")"
        self.product_adate = "\(dict["product_adate"] ?? "")"
        
        if let delivery_type = dict["delivery_type"] as? [[String:Any]] {
            let dict_delivery_type = delivery_type[1]
            self.delivery_days = "\(dict_delivery_type["delivery_days"] ?? "")"
        }
        
        if let arr_product_images = dict["product_images"] as? [[String:Any]] {
            for dict in arr_product_images {
                self.product_images.append(func_set_product_images(dict: dict))
            }
        }
        
        self.product_sizes = "\(dict["product_sizes"] ?? "")"
        self.product_color = "\(dict["product_color"] ?? "")"
        
        self.category_id = "\(dict["category_id"] ?? "")"
        self.category_icon = "\(dict["category_icon"] ?? "")"
        self.category_name = "\(dict["category_name"] ?? "")"
        self.category_status = "\(dict["category_status"] ?? "")"
        
        self.subcate_id = "\(dict["subcate_id"] ?? "")"
        self.subcategory_icon = "\(dict["subcategory_icon"] ?? "")"
        self.subcategory_name = "\(dict["subcategory_name"] ?? "")"
        self.subcategory_code = "\(dict["subcategory_code"] ?? "")"
        self.subcategory_status = "\(dict["subcategory_status"] ?? "")"
        self.inwishlist = "\(dict["inwishlist"] ?? "")"
        self.isrecent = "\(dict["isrecent"] ?? "")"
        self.cart_id = "\(dict["cart_id"] ?? "")"
        self.isbag = "\(dict["isbag"] ?? "")"
        
        self.product_material = "\(dict["product_material"] ?? "")"
        self.product_season = "\(dict["product_season"] ?? "")"
        self.poduct_origin = "\(dict["poduct_origin"] ?? "")"
        self.product_is_washing = "\(dict["product_is_washing"] ?? "")"
        
        self.currency_id = "\(dict["currency_id"] ?? "")"
        self.currency_name = "\(dict["currency_name"] ?? "")"
        self.currency_symbol = "\(dict["currency_symbol"] ?? "")"
        self.product_size_guide_id = "\(dict["product_size_guide_id"] ?? "")"
        
        let str_currency_price = "\(dict["currency_price"] ?? "1")".trimmingCharacters(in:.whitespaces)
        if str_currency_price.isEmpty {
            self.currency_price = "1"
        } else {
            self.currency_price = str_currency_price
        }
        
        self.product_currency_name = "\(dict["product_currency_name"] ?? "")"
        self.product_currency_symbol = "\(dict["product_currency_symbol"] ?? "")"
        self.product_currency_price = "\(dict["product_currency_price"] ?? "1")".trimmingCharacters(in:.whitespaces)
        
        if let arr_Subcategory = dict["related_products"] as? [[String:Any]] {
            for dict in arr_Subcategory {
                self.related_products.append(self.func_set_related_products(dict: dict))
            }
        }
        
        if let arr_delivery_type = dict["delivery_type"] as? [[String:Any]] {
            for dict in arr_delivery_type {
                self.arr_delivery_type.append(self.func_set_delivery_options(dict: dict))
            }
        }
        
//        return model
    }
    
    private func func_set_product_images(dict:[String:Any]) -> Model_Product_details{
        let model = Model_Product_details()
        
        model.product_image_id = "\(dict["product_image_id"] ?? "")"
        model.image_path = "\(dict["image_path"] ?? "")"
        model.product_id = "\(dict["product_id"] ?? "")"
        
        return model
    }
    
    func func_set_related_products(dict:[String:Any]) -> Model_Product_details {
        let model = Model_Product_details()
        
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
        
        model.currency_id = "\(dict["currency_id"] ?? "")"
        model.currency_name = "\(dict["currency_name"] ?? "")"
        model.currency_symbol = "\(dict["currency_symbol"] ?? "")"
        model.currency_price = "\(dict["currency_price"] ?? "")".trimmingCharacters(in:.whitespaces)
        model.product_currency_name = "\(dict["product_currency_name"] ?? "")"
        model.product_currency_symbol = "\(dict["product_currency_symbol"] ?? "")"
        model.product_currency_price = "\(dict["product_currency_price"] ?? "")".trimmingCharacters(in:.whitespaces)
        
        return model
    }
    
    
    
    func func_add_to_wishlist(completionHandler:@escaping (String)->()) {
        let param = [
                        "product_id":product_id,
                        "customer_id":Model_Walk_Through.shared.customer_id
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
    
    func func_add_recently(completionHandler:@escaping (String)->()) {
        let param = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "product_id":product_id
        ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"add_recently", parameters: param) {
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
        
    func func_add_to_cart(completionHandler:@escaping (String)->()) {
        let param = [
            "customer_id":Model_Walk_Through.shared.customer_id,
            "product_id":product_id,
            "product_qty":"1",
            "product_size":product_size,
            "product_price":product_price,
            "admin_currency":product_currency_price
        ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"add_to_cart", parameters: param) {
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
            "product_size":product_size,
            "product_qty":"1"
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
    
    
    func func_get_wish_list(completionHandler:@escaping (String)->()) {
        let param = [
            "customer_id":Model_Walk_Through.shared.customer_id
        ]
        print(param)
        
        APIFunc.postAPI(url: k_base_url+"get_wish_list", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_get_wish_list.removeAll()
            
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
    
    private func func_get_wishlist(dict:[String:Any]) -> Model_Wishlist {
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
        
        model.category_id = "\(dict["category_id"] ?? "")"
        model.category_icon = "\(dict["category_icon"] ?? "")"
        model.category_name = "\(dict["category_name"] ?? "")"
        model.category_status = "\(dict["category_status"] ?? "")"
        
        model.subcate_id = "\(dict["subcate_id"] ?? "")"
        model.subcategory_icon = "\(dict["subcategory_icon"] ?? "")"
        model.subcategory_name = "\(dict["subcategory_name"] ?? "")"
        model.subcategory_code = "\(dict["subcategory_code"] ?? "")"
        model.subcategory_status = "\(dict["subcategory_status"] ?? "")"
        
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
        model.product_currency_price = "\(dict["product_currency_price"] ?? "")"
        
        return model
    }
    
    private func func_set_delivery_options(dict:[String:Any]) -> Model_Product_details {
        let model = Model_Product_details()
        
        model.delivery_type_id = "\(dict["delivery_type_id"] ?? "")"
        model.delivery_type = "\(dict["delivery_type"] ?? "")"
        model.delivery_description = "\(dict["delivery_description"] ?? "")"
        model.delivery_type_cost = "\(dict["delivery_type_cost"] ?? "")"
        model.delivery_days = "\(dict["delivery_days"] ?? "")"
        
        return model
    }
    
}




