//  About_ViewController.swift
//  FGB
//  Created by appentus on 6/20/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class About_ViewController: UIViewController {
    @IBOutlet weak var lbl_description:UITextView!
    @IBOutlet weak var lbl_about_product:UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_about_product.text = "about".localized
        
        lbl_description.text = Model_Product_details.shared.product_description
        if lbl_description.text!.isEmpty {
            lbl_description.text = "Description"
        }
    }
    
    @IBAction func btn_close(_ sender:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "product_about"), object: nil)
    }
    
}
