//
//  About_Terms_Cond_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

var str_About_Terms_Cond = ""

class About_Terms_Cond_ViewController: UIViewController,UIWebViewDelegate{
    
    @IBOutlet weak var nav_bar:UINavigationItem!
    @IBOutlet weak var webview:UIWebView!
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        nav_bar.title = str_About_Terms_Cond
        
        webview.loadRequest(URLRequest(url: URL (string: "https://appentus.com/about.php")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        func_ShowHud()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        func_HideHud()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
    
}
