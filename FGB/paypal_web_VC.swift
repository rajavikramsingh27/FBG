//
//  paypal_web_VC.swift
//  FGB
//
//  Created by Rajat Pathak on 10/07/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class paypal_web_VC: UIViewController , UIWebViewDelegate {

    @IBOutlet weak var web_view: UIWebView!
    @IBOutlet weak var nav_bar: UINavigationBar!
    
    var success = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://appentus.me/FGB/api/Api/payment_view?customer_id=\(Model_Walk_Through.shared.customer_id)&amount=\(model_paypal_pay_detail.shared.price)&currency=\(model_paypal_pay_detail.shared.currency)"
        let request = URLRequest(url: URL(string: url)!)
        web_view.loadRequest(request)
        nav_bar.applyNavGradient()
        // Do any additional setup after loading the view.
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        do {
            if let url = request.url {
                
                print(url)
                
                let url_string = "\(url)"
                if url_string == "http://appentus.me/FGB/api/api/payment_fail"{
                    success = 0
                    func_ShowHud_Error(with: "Payment Failed")
                }else if url_string.contains("http://appentus.me/FGB/api/api/payment_success"){
                    success = 1
                   func_paypal_payment()
                    func_ShowHud_Success(with: "Payment successful")
                    
                }else if url_string.contains("checkout/done"){
                    success = 1
                    func_ShowHud_Success(with: "Payment successful")
                    func_paypal_payment()
                }
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        return true
    }
    
    func func_paypal_payment() {
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "paypal_payment"), object: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func back(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Payment will be declined ! Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print("default")
            if self.success == 0{
                self.dismiss(animated: true, completion: nil)
            }else{
                self.func_paypal_payment()
            }

            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
                print("default")
                
            }))
        self.present(alert, animated: true, completion: nil)
    }
}
