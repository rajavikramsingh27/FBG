




//
//  Paypal_Login_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Paypal_Login_ViewController: UIViewController {
    @IBOutlet weak var btn_save_changes:UIButton!
    
    @IBOutlet weak var txt_login:UITextField!
    @IBOutlet weak var txt_password:UITextField!
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        
        btn_save_changes.layer.cornerRadius = btn_save_changes.frame.size.height/2
        btn_save_changes.clipsToBounds = true
        
        if Model_paypal_login.shared.is_edit {
            let model = Model_paypal_login.shared.card_details
            txt_login.text = model.payment_email
            Model_paypal_login.shared.card_id = model.card_id
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_save_changes(_ sender:Any) {
        if !func_validation() {
            return
        }
        
        if Model_paypal_login.shared.is_edit {
            func_update_card()
        } else {
            func_add_card()
        }
        
    }

    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func func_add_card() {
        Model_paypal_login.shared.payment_email = txt_login.text!
        
        func_ShowHud()
        Model_paypal_login.shared.func_add_card { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_paypal_login.shared.str_message)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        self.func_HideHud()
                        if is_add_pay_first {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
                        }
                    }
                } else {
                    self.func_ShowHud_Error(with: Model_paypal_login.shared.str_message)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        self.func_HideHud()
                    }
                }
            }
        }
    }
    
    func func_update_card() {
        Model_paypal_login.shared.payment_email = txt_login.text!
        
        func_HideHud()
        Model_paypal_login.shared.func_update_card { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_paypal_login.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        self.func_HideHud()
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    self.func_ShowHud_Error(with: Model_paypal_login.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        self.func_HideHud()
                    }
                }
            }
        }
    }

    func func_validation() -> Bool {
        var is_false = false
        if txt_login.text!.isEmpty {
            func_ShowHud_Error(with: "Enter your paypal user name")
            is_false = false
        } else if txt_password.text!.isEmpty {
            func_ShowHud_Error(with: "Enter your paypal paypal")
            is_false = false
        } else {
            is_false = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.func_HideHud()
        }
        return is_false
    }


}









