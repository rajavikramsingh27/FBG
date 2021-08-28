
//  Model_Size_GuizeSize_Guize.swift
//  FGB
//  Created by appentus on 6/20/19.
//  Copyright © 2019 appentus. All rights reserved.



import Foundation



class Model_Size_Guize {
    static let shared = Model_Size_Guize()
    
    var arr_size_guide_uk = [String]()
    var arr_size_guide_eu = [String]()
    var arr_size_guide_usa = [String]()
    
    var size_guide_id = "1"
    var str_message = ""
    
    func func_size_guide_data(completionHandler:@escaping (String)->()) {
        let params = [
            "size_guide_id":size_guide_id
        ]
        print(params)
        
        APIFunc.postAPI(url: k_base_url+"size_guide_data", parameters: params) {
            (dict_JSON) in
            print(dict_JSON)
            
            if dict_JSON["status"] as? String == "success" {
                if let dict_Result = dict_JSON["result"] as? [[String:Any]] {
                    let size_guide_uk = "\(dict_Result[0]["size_guide_uk"]!)"
                    let size_guide_eu = "\(dict_Result[0]["size_guide_eu"]!)"
                    let size_guide_usa = "\(dict_Result[0]["size_guide_usa"]!)"
                    
                    self.arr_size_guide_uk = size_guide_uk.components(separatedBy: ",")
                    self.arr_size_guide_uk.insert("UK", at: 0)
                    self.arr_size_guide_eu = size_guide_eu.components(separatedBy: ",")
                    self.arr_size_guide_eu.insert("EU", at: 0)
                    self.arr_size_guide_usa = size_guide_usa.components(separatedBy: ",")
                    self.arr_size_guide_usa.insert("US", at: 0)
                }
                completionHandler(dict_JSON["status"] as! String)
            } else {
                if let str_status = dict_JSON["status"] as? String {
                    if str_status == "failed" {
                        self.str_message = dict_JSON["message"] as! String
                        completionHandler(dict_JSON["status"] as! String)
                    } else {
                        completionHandler("failed")
                    }
                } else {
                    completionHandler("failed")
                }
            }
        }
    }
    
}


