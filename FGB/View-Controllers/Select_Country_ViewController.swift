


//  Select_Country_ViewController.swift
//  FGB

//  Created by iOS-Appentus on 20/06/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit

class Select_Country_ViewController: UIViewController {
    @IBOutlet weak var lbl_sa:UILabel!
    @IBOutlet weak var lbl_others:UILabel!
    @IBOutlet weak var lbl_select_country:UILabel!
    
    @IBOutlet weak var btn_sa:UIButton!
    @IBOutlet weak var btn_other:UIButton!
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_select_country.text = "select_country".localized
        lbl_sa.text = "saudi".localized
        lbl_others.text = "other".localized
        
        set_gradient_on_label(lbl: lbl_sa)
        set_gradient_on_label(lbl: lbl_others)
    }
    
    @IBAction func btn_sa(_ sender:UIButton) {
        btn_sa.isSelected = true
        btn_other.isSelected = false
        
        Model_setting.shared.customer_currency = "1"
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "select_Country"), object: nil)
    }
    
    @IBAction func btn_other(_ sender:UIButton) {
        btn_other.isSelected = true
        btn_sa.isSelected = false
        
        Model_setting.shared.customer_currency = "2"
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "select_Country"), object: nil)
    }
    
    
    
}
