//  Model_filter.swift
//  FGB

//  Created by iOS-Appentus on 16/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import Foundation

class Model_filter {
    static let shared = Model_filter()
    
    var color_id = ""
    var color_name = ""
    var color_code = ""
    
    var size = ""
    var color = ""
    var mini_price = ""
    var max_price = ""
    var sort_type = ""
    var collection_types = ""
    
    
        
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
    var size_guide_id = ""
    var str_message = ""
    
    var arr_color = [Model_filter]()
    var arr_sizes = [String]()
    var arr_filter = [Model_Item_Details]()
    
    
    
    func func_filter_prodcut(completionHandler:@escaping (String)->()) {
        
            category_code = "\(dict_filter["category_code"] ?? "")"
            subcate_code = "\(dict_filter["subcate_code"] ?? "")"
            size = "\(dict_filter["size"] ?? "")"
            color = "\(dict_filter["color"] ?? "")"
            sort_type = "\(dict_filter["sort_type"] ?? "")"
            mini_price = "\(dict_filter["mini_price"] ?? "")"
            max_price = "\(dict_filter["max_price"] ?? "")"
            collection_types = "\(dict_filter["collection_type"] ?? "")"
        
            if size == "All"  {
                size = ""
            }
        
            if sort_type == "All"  {
                sort_type = ""
            }else if sort_type == "New"{
                sort_type = "new"
            }else if sort_type == "Popular"{
                sort_type = "popular"
            }else if sort_type == "Price: high to low"{
                sort_type = "high_to_low"
            }else if sort_type == "Price: low to high"{
                sort_type = "low_to_high"
            }
        
            if color == "All"  {
                color = ""
            }
        
            if mini_price == "10" {
                mini_price = ""
            } else {
                if currency_idd != "1" {
                    mini_price = "\(Double(mini_price)!/Double(currency_price)!)"
                }
            }
        
            if max_price == "1400" {
                max_price = ""
            } else {
                if currency_idd != "1" {
                    max_price = "\(Double(max_price)!/Double(currency_price)!)"
                }
            }
        
        let params = [
            "category_code":category_code,
            "subcate_code":subcate_code,
            "size":size,
            "color":color,
            "mini_price":mini_price,
            "max_price":max_price,
            "sort_type":sort_type,
            "currency_id":currency_idd,
            "collection_type":collection_types
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"filter_prodcut", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_filter.removeAll()
            Model_Search.shared.arr_searched.removeAll()
            Model_Item_Details.shared.arr_get_products.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                let arr_result = dict_JSON["result"] as! [[String:Any]]
                for dict in arr_result {
                    self.arr_filter.append(self.func_get_home_product(dict: dict))
                    Model_Search.shared.arr_searched.append(self.func_set_filtered(dict: dict))
                    Model_Item_Details.shared.arr_get_products = self.arr_filter
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
    
    
    private func func_get_home_product(dict:[String:Any]) -> Model_Item_Details {
        let model = Model_Item_Details()
        
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
    
    private func func_set_filtered(dict:[String:Any]) -> Model_Search {
        let model = Model_Search()
        
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
        model.currency_price = "\(dict["currency_price"] ?? "")"
        
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
    
    
    private func func_set_filtered_items(dict:[String:Any]) -> Model_Item_Details {
        let model = Model_Item_Details()
        
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
    
    
    var Subcategory = [Model_filter]()
    var arr_category_subcate = [Model_filter]()
    
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
    
    private func func_set_category_subcate(dict:[String:Any]) -> Model_filter {
        let model = Model_filter()
        
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
    
    func func_set_subcate(dict:[String:Any]) -> Model_filter {
        let model = Model_filter()
        
        model.category_id = "\(dict["category_id"] ?? "")"
        
        model.subcate_id = "\(dict["subcate_id"] ?? "")"
        model.subcategory_icon = "\(dict["subcategory_icon"] ?? "")"
        model.subcategory_name = "\(dict["subcategory_name"] ?? "")"
        model.subcategory_code = "\(dict["subcategory_code"] ?? "")"
        model.subcategory_status = "\(dict["subcategory_status"] ?? "")"
        model.size_guide_id = "\(dict["size_guide_id"] ?? "")"
        
        return model
    }
    
    func func_get_subcategory_size(completionHandler:@escaping (String)->()) {
        var size_in = ""
        if let default_value = UserDefaults.standard.object(forKey: "Sizes") as? String {
            size_in = default_value
        } else {
            size_in = "uk"
        }
        
        let param = ["size_in":size_in,"size_guide_id":size_guide_id]
        APIFunc.postAPI(url: k_base_url+"get_subcategory_size", parameters: param) {
            (dict_JSON) in
            print(dict_JSON)
            
            self.arr_color.removeAll()
            self.arr_sizes.removeAll()
            
            if dict_JSON["status"] as? String == "success" {
                let dict_result = dict_JSON["result"] as! [String:Any]
                
                let arr_colors = dict_result["colors"] as! [[String:Any]]
                for dict in arr_colors {
                    self.arr_color.append(self.func_set_color(dict: dict))
                }
                
                let size_guide = "\(dict_result["size_guide"]!)"
                self.arr_sizes = size_guide.components(separatedBy: ",")
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

    
    func func_set_color(dict:[String:Any]) -> Model_filter {
        let model = Model_filter()
        
        model.color_id = "\(dict["color_id"] ?? "")"
        model.color_name = "\(dict["color_name"] ?? "")"
        model.color_code = "\(dict["color_code"] ?? "")"
        
        return model
    }

    
}






