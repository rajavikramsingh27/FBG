//
//  Reset_Password_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 10/04/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit
import SVProgressHUD

class Reset_Password_ViewController: UIViewController {
    
    @IBOutlet weak var txt_old_pwd:UITextField!
    @IBOutlet weak var txt_new_pwd:UITextField!
    @IBOutlet weak var txt_confirm_pwd:UITextField!
    
    @IBOutlet weak var btn_submit:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        btn_submit.layer.cornerRadius = btn_submit.frame.size.height/2
        btn_submit.clipsToBounds = true
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_submit(_ sender:UIButton) {
        self.view.endEditing(true)
        
        if !func_validation() {
            return
        }
        func_reset_password()
    }
    
    
    func func_reset_password() {
        func_ShowHud()
        Model_Reset_Password.shared.old_password = txt_old_pwd.text!
        Model_Reset_Password.shared.new_password = txt_new_pwd.text!
        
        Model_Reset_Password.shared.func_reset_password { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Reset_Password.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Reset_Password.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    self.func_HideHud()
                    if status == "success" {
                     self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func func_reset_password_23424324() {
        SVProgressHUD.show()
        Model_Reset_Password.shared.old_password = txt_old_pwd.text!
        Model_Reset_Password.shared.new_password = txt_new_pwd.text!
        
        Model_Reset_Password.shared.func_reset_password { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
                if status == "success" {
                    SVProgressHUD.showSuccess(withStatus: Model_Reset_Password.shared.str_message)
                } else {
                    SVProgressHUD.showError(withStatus: Model_Reset_Password.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {
//                    self.func_HideHud()
//                    SVProgressHUD.dismiss()
                    if status == "success" {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
//            }
        }
    }
    
    func func_validation() -> Bool {
        var is_false = false
        if txt_old_pwd.text!.isEmpty {
            func_ShowHud_Error(with: "Enter old password")
            is_false = false
        } else if txt_old_pwd.text!.count < 6 {
            func_ShowHud_Error(with: "Old password enter minmum 6 characters")
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else if txt_new_pwd.text!.isEmpty {
            func_ShowHud_Error(with: "Enter new password")
            is_false = false
        } else if txt_new_pwd.text!.count < 6 {
            func_ShowHud_Error(with: "New password enter minmum 6 characters")
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else if txt_confirm_pwd.text!.isEmpty {
            func_ShowHud_Error(with: "Enter new password")
            is_false = false
        } else if txt_confirm_pwd.text! != txt_new_pwd.text! {
            func_ShowHud_Error(with: "New password and confirm password must be same")
            is_false = false
        } else {
            is_false = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.func_HideHud()
        }
        
        return is_false
    }
 
    func func_validatoin() -> Bool {
        if txt_old_pwd.text!.isEmpty {
            func_ShowHud_Error(with: "Enter password")
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else if txt_new_pwd.text!.count < 6 {
            func_ShowHud_Error(with: "Minimum password 6 characters")
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else {
            return true
        }
    }
    
}
