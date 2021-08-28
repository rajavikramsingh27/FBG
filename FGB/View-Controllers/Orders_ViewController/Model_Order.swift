//  Model_Order.swift
//  FGB
//  Created by iOS-Appentus on 19/03/19.
//  Copyright © 2019 appentus. All rights reserved.


import Foundation



class Model_Order {
    static let shared = Model_Order()
    
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
    
    var product_about = ""
    
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
    
    var order_items_id = ""
    var order_items_code = ""
    var order_customer_id = ""
    var order_product_id = ""
    var order_product_qty = ""
    var order_product_size = ""
    var order_product_price = ""
    var order_product_total = ""
    var order_product_status = ""
    
    var customer_id = ""
    var delivery_address = ""
    var payment_method_type = ""
    var order_date = ""
    var delivery_type = ""
    var delivery_type_cost = ""
    var delivery_description = ""
    
    var taxname = ""
    var tax_rate = ""
    var currency_name = ""
    var currency_price = ""
    
    var reason_id = ""
    var reason_name = ""
    
    var str_message = ""
    
    var page = "1"
    var count = "0"
    
    var arr_reason_list = [Model_Order]()
    var arr_order_list = [Model_Order]()
    
    var product_image_id = ""
    var delivery_charges = ""
    var country = ""
    var tax_amount = ""
    var admin_currency = ""
    var promo_discount = ""
    var wallet_discount = ""
    var size_guide_id = ""
    var collection_code = ""
    var product_currency_id = ""
    
    var product_for = ""
    var product_size_guide_id = ""
    var product_material = ""
    var product_season = ""
    var poduct_origin = ""
    var product_is_washing = ""
    var product_collection_type = ""
    var refund_policy = ""
    var cancel_active = ""
    var days = ""
    var order_shipping_note = ""
    var delivery_days = ""
    
    
    
    func func_order_list(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id,
                     "page":page]
        
        APIFunc.postAPI(url: k_base_url+"order_list", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
//            self.arr_order_list.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                if let _ = dict_JSON["count"] as? NSArray {
                    self.count = "0"
                } else {
                    self.count = "\(dict_JSON["count"]!)"
                }
                
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_order_list.append(self.func_set_order_list(dict: dict))
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
    
    private func func_set_order_list(dict:[String:Any]) -> Model_Order {
        let model = Model_Order()
        
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
        
        model.product_about = "\(dict["product_about"] ?? "")"
        
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
        
        model.order_items_id = "\(dict["order_items_id"] ?? "")"
        model.order_items_code = "\(dict["order_items_code"] ?? "")"
        model.order_customer_id = "\(dict["order_customer_id"] ?? "")"
        model.order_product_id = "\(dict["order_product_id"] ?? "")"
        model.order_product_qty = "\(dict["order_product_qty"] ?? "")"
        model.order_product_size = "\(dict["order_product_size"] ?? "")"
        model.order_product_price = "\(dict["order_product_price"] ?? "")"
        model.order_product_total = "\(dict["order_product_total"] ?? "")"
        model.order_product_status = "\(dict["order_product_status"] ?? "")"
        
        model.customer_id = "\(dict["customer_id"] ?? "")"
        model.delivery_address = "\(dict["delivery_address"] ?? "")"
        model.payment_method_type = "\(dict["payment_method_type"] ?? "")"
        model.order_date = "\(dict["order_date"] ?? "")"
        model.delivery_type = "\(dict["delivery_type"] ?? "")"
        model.delivery_type_cost = "\(dict["delivery_type_cost"] ?? "")"
        model.delivery_description = "\(dict["delivery_description"] ?? "")"
        
        model.taxname = "\(dict["taxname"] ?? "")"
        model.tax_rate = "\(dict["tax_rate"] ?? "")"
        model.currency_name = "\(dict["currency_name"] ?? "")"
        model.currency_price = "\(dict["currency_price"] ?? "")"
        
        model.product_for = "\(dict["product_for"] ?? "")"
        model.product_size_guide_id = "\(dict["product_size_guide_id"] ?? "")"
        model.product_material = "\(dict["product_material"] ?? "")"
        model.product_season = "\(dict["product_season"] ?? "")"
        
        model.poduct_origin = "\(dict["poduct_origin"] ?? "")"
        model.product_is_washing = "\(dict["product_is_washing"] ?? "")"
        model.product_collection_type = "\(dict["product_collection_type"] ?? "")"
        model.refund_policy = "\(dict["refund_policy"] ?? "")"
        
        model.cancel_active = "\(dict["cancel_active"] ?? "")"
        model.days = "\(dict["days"] ?? "")"
        model.order_shipping_note = "\(dict["order_shipping_note"] ?? "")"
        model.delivery_days = "\(dict["delivery_days"] ?? "")"
        
        model.wallet_discount = "\(dict["wallet_discount"] ?? "")"
        model.promo_discount = "\(dict["promo_discount"] ?? "")"
        
        return model
    }
    
    func func_cancel_order_item(completionHandler:@escaping (String)->()) {
        let param = ["order_item_id":order_items_id]
        
        APIFunc.postAPI(url: k_base_url+"cancel_order_item", parameters: param) {
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
    
    func func_reason_list(completionHandler:@escaping (String)->()) {
        APIFunc.getAPI(url: k_base_url+"reason_list", parameters: [:]) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_reason_list.removeAll()
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_reason_list.append(self.func_set_reason(dict: dict))
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
    
    
    private func func_set_reason(dict:[String:Any]) -> Model_Order {
        let model = Model_Order()
        
        model.reason_id = "\(dict["reason_id"] ?? "")"
        model.reason_name = "\(dict["reason_name"] ?? "")"
        
        return model
    }
    
    
    func func_product_return(completionHandler:@escaping (String)->()) {
        let param = ["customer_id":Model_Walk_Through.shared.customer_id,
                        "product_id":product_id,
                        "order_id":order_items_id,
                        "return_reason":reason_name
                     ]
        
        APIFunc.postAPI(url: k_base_url+"product_return", parameters: param) {
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

    
}


