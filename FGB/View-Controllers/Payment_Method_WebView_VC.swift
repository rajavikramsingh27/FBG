//
//  Payment_Method_WebView_VC.swift
//  FGB
//
//  Created by appentus technologies pvt. ltd. on 9/23/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Payment_Method_WebView_VC: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webview:UIWebView!
    
    var str_URL_PaymentMethod = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.loadRequest(URLRequest (url: URL(string: str_URL_PaymentMethod)!))
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
//        func_ShowHud()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        func_HideHud()
//        print(webview.request)
        
//        let headers = webView.request?.allHTTPHeaderFields
//        for (key,value) in headers! {
//            print("key \(key) value \(value)")
//        }
        
        let response = "\(webview.request!)"
        if response.contains("http://appentus.me/FGB/payment/success.php") {
            func_ShowHud_Success(with: "Payment Successfull Completed")
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
                NotificationCenter.default.post(name: NSNotification.Name (rawValue: "payment_success"), object: nil)
                self.presentingViewController?.presentingViewController?.presentingViewController!.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
    @IBAction func btn_cancel(_ sender:UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
