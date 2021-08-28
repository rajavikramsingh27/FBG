
//  Social_ViewController.swift
//  FGB

//  Created by appentus on 6/28/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

var str_social_link = ""

class Social_ViewController: UIViewController ,UIWebViewDelegate {
    
    @IBOutlet weak var web_view:UIWebView!
    @IBOutlet weak var nav_bar:UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_bar.applyNavGradient()
        let url_requ = URLRequest (url: URL (string: str_social_link)!)
        web_view.loadRequest(url_requ)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        func_ShowHud()
        self.view.isUserInteractionEnabled = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        func_HideHud()
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
}





