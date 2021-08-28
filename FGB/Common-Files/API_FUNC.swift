//
//  File.swift
//  FGB
//
//  Created by iOS-Appentus on 13/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD


class APIFunc {
    class func postAPI(url: String , parameters: [String:Any] , completion: @escaping ([String:Any]) -> ()){
        if Reachability.isConnectedToNetwork() {
            let apiURL = url
            let param = parameters
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 80
            
            manager.request(apiURL, method: .post, parameters: param).validate().responseString { (response) in
                switch response.result {
                case .success:
                    let responseJson = anyConvertToDictionary(text: response.result.value!) as AnyObject
                    let dict_cleaned = cleanJsonToObject(data: responseJson) as! [String:Any]
                    completion(dict_cleaned)
                    
                    break
                case .failure(let error):
                    completion(["status":"failed","message":"\(error.localizedDescription)"])
                    print(error)
                    
                    break
                }
            }
        } else {
            SVProgressHUD.showError(withStatus: "Internet Connection not Available!")
        }
    }
    
    class func getAPI(url: String , parameters: [String:Any] , completion: @escaping ([String:Any]) -> ()){
        if Reachability.isConnectedToNetwork(){
            let apiURL = url
            let param = parameters
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 80
            
            manager.request(apiURL, method: .get, parameters: param).validate().responseString { (response) in
                switch response.result {
                case .success:
                    let responseJson = anyConvertToDictionary(text: response.result.value!) as AnyObject
                    let dict_cleaned = cleanJsonToObject(data: responseJson) as! [String:Any]
                    completion(dict_cleaned)

                    break
                case .failure(let error):
                    completion(["status":"failed","message":"\(error.localizedDescription)"])
                    
                    break
                }
            }
            
            
        }else{
            SVProgressHUD.showError(withStatus: "Internet Connection not Available!")
        }
        
    }

    
    
    class func func_Payment(url: String , requestParams:[String:Any], completion: @escaping ([String:Any]) -> ()) {
        if Reachability.isConnectedToNetwork() {
            let url = URL(string: url)
            var request = URLRequest(url: url!)
            request.setValue("Bearer sk_test_rzJxc2vId03WlBps4oPQt1KZ", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: requestParams, options: [])
            
            Alamofire.request(request).responseJSON { (response) in
                switch response.result {
                case .success:
                    let dict_cleaned = cleanJsonToObject(data:response.result.value as AnyObject) as! [String:Any]
                    completion(dict_cleaned)
                    
                    break
                case .failure(let error):
                    completion(["status":"failed","message":"\(error.localizedDescription)"])
                    
                    break
                }
            }
        } else {
            SVProgressHUD.showError(withStatus: "Internet Connection not Available!")
        }
        
    }
    
    
    
    class func func_UploadWithImage(endUrl: String,imageData: Data?, parameters: [String : String],img_param:String, completionHandler:@escaping ([String:Any])->()) {
        if Reachability.isConnectedToNetwork() {
            let url = URL (string: endUrl) /* your API url */
            
            let headers: HTTPHeaders = [
                "Content-type": "multipart/form-data"
            ]
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 80
            
            manager.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if let data = imageData {
                    multipartFormData.append(data, withName: img_param, fileName: "image.png", mimeType: "image/png")
                }
            }, usingThreshold: UInt64.init(), to: url!, method: .post, headers: headers) { (result) in
                
               // print(result)
                 
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        do {
                            let json =  try JSONSerialization .jsonObject(with:response.data!
                                , options: .allowFragments)  as AnyObject
                            //print(json)
                            let dict_cleaned = cleanJsonToObject(data: json) as! [String:Any]
                            completionHandler(dict_cleaned)
                        }
                        catch let error as NSError {
                            print("error is:-",error)
                            completionHandler(["status":"failed","message":"\(error)"])
                        }
                    }
                case .failure(let error):
                    print("Error in upload: \(error.localizedDescription)")
                    completionHandler(["status":"failed","message":"\(error.localizedDescription)"])
                }
            }
            
        } else {
            SVProgressHUD.showError(withStatus: "Internet Connection not Available!")
        }
    }
    
}



func anyConvertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
            
        }
    }
    return nil
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}



func cleanJsonToObject(data : AnyObject) -> AnyObject {
    
    let jsonObjective : Any = data
    
    if jsonObjective is NSArray {
        
        //            let array : NSMutableArray = (jsonObjective as AnyObject) as! NSMutableArray
        
        let jsonResult : NSArray = (jsonObjective as? NSArray)!
        
        
        
        let array: NSMutableArray = NSMutableArray(array: jsonResult)
        
        
        
        //            for (int i = (int)array.count-1; i >= 0; i--)
        for  i in stride(from: array.count-1, through: 0, by: -1)
        {
            let a : AnyObject = array[i] as AnyObject;
            
            if a as! NSObject == NSNull(){
                array.removeObject(at: i)
                
            } else {
                array[i] = cleanJsonToObject(data: a)
                
                //                        [self cleanJsonToObject:a];
            }
        }
        return array;
    } else if jsonObjective is NSDictionary  {
            
            let jsonResult : Dictionary = (jsonObjective as? Dictionary<String, AnyObject>)!
            
            let dictionary: NSMutableDictionary = NSMutableDictionary(dictionary: jsonResult)
            
            //            let dictionary : NSMutableDictionary = (jsonResult as? NSMutableDictionary<String, AnyObject>)!
            
            for  key in dictionary.allKeys {
                
                let  d : AnyObject = dictionary[key as! NSCopying]! as AnyObject
                
                if d as! NSObject == NSNull()
                {
                    dictionary[key as! NSCopying] = ""
                }
                else
                {
                    dictionary[key as! NSCopying] = cleanJsonToObject(data: d )
                }
            }
            return dictionary;
        }
        else {
            return jsonObjective as AnyObject;
    }
    
    
    //        return data
}


