//
//  Credit_Debit_Card_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

import BKMoneyKit

class Credit_Debit_Card_ViewController: UIViewController {
    @IBOutlet weak var btn_save_changes:UIButton!
    
    @IBOutlet weak var txt_card_number:BKCardNumberField!
    @IBOutlet weak var txt_expiry_date:UITextField!
    @IBOutlet weak var txt_name_of_card:UITextField!
    
    @IBOutlet weak var view_picker_container:UIView!
    @IBOutlet weak var picker_view:UIPickerView!
    
    var arr_picker_month = ["Jan","Feb","Mar","Apr","May","June","Jul","Aug","Sep","Oct","Nov","Dec"]
    var arr_picker_month_No = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    var arr_picker_year = [String]()
    
    var exp_month = "Jan"
    var exp_month_no = "1"
    var exp_year = ""
    
    var is_name_of_card = false
    let  arr_picker_name_of_card = ["Debit card","Credit card"]
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        
        func_textfield_placeholder(textfield: txt_card_number, placeholder_text: "Card Number")
        txt_card_number.showsCardLogo = true
        
        picker_view.setValue(UIColor.white, forKeyPath: "textColor")
        
        view_picker_container.isHidden = true
        view_picker_container.layer.cornerRadius = 10
        view_picker_container.clipsToBounds = true
        
        btn_save_changes.layer.cornerRadius = btn_save_changes.frame.size.height/2
        btn_save_changes.clipsToBounds = true
        
        for i in 0...21 {
            let calendar = Calendar.current
            let newDate = calendar.date(byAdding: .year, value:i, to: Date())
            
            let date_format = DateFormatter()
            date_format.dateFormat = "yyyy"
            arr_picker_year.append(date_format.string(from: newDate!))
        }
        
        print(arr_picker_year)
        exp_year = arr_picker_year[0]
        
        if Model_credit_card.shared.is_edit {
            let model = Model_credit_card.shared.card_details
            txt_card_number.text = model.card_number
            txt_expiry_date.text = model.card_exp_date
            txt_name_of_card.text = model.card_type
            
            Model_credit_card.shared.card_id = model.card_id
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_exp_date(_ sender:Any) {
        self.view.endEditing(true)
        is_name_of_card = false
        view_picker_container.isHidden = false
        picker_view.reloadAllComponents()
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_name_of_card(_ sender:Any) {
        self.view.endEditing(true)
        is_name_of_card = true
        view_picker_container.isHidden = false
        picker_view.reloadAllComponents()
    }
    
    @IBAction func btn_save_changes(_ sender:Any) {
        if !func_validation() {
            return
        }
        
        if Model_credit_card.shared.is_edit {
            func_update_card()
        } else {
            func_add_card()
        }
        
    }

    
    @IBAction func btn_done_picker(_ sender:UIButton) {
        view_picker_container.isHidden = true
    }
    
    func func_add_card() {
        Model_credit_card.shared.card_number = txt_card_number.text!
        Model_credit_card.shared.card_exp_date = txt_expiry_date.text!
        Model_credit_card.shared.card_type = txt_name_of_card.text!
        
        func_ShowHud()
        Model_credit_card.shared.func_add_card { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_credit_card.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        self.func_HideHud()
                        if is_add_pay_first {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
                        }
                    }
                } else {
                    self.func_ShowHud_Error(with: Model_credit_card.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.func_HideHud()
                    }
                }
            }
        }
    }
    
    func func_update_card() {
        Model_credit_card.shared.card_number = txt_card_number.text!
        Model_credit_card.shared.card_exp_date = txt_expiry_date.text!
        
        func_ShowHud()
        Model_credit_card.shared.func_update_card { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_credit_card.shared.str_message)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        self.func_HideHud()
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    self.func_ShowHud_Error(with: Model_credit_card.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        self.func_HideHud()
                    }
                }
            }
        }
    }
    
    func func_validation() -> Bool {
        var is_false = false
        if txt_card_number.text!.isEmpty {
            func_ShowHud_Error(with: "Enter your card number")
            is_false = false
        } else if txt_expiry_date.text!.isEmpty {
            func_ShowHud_Error(with: "Enter your expiry date")
            is_false = false
        } else if txt_name_of_card.text!.isEmpty {
            func_ShowHud_Error(with: "Enter your card name")
            is_false = false
        } else {
            is_false = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.func_HideHud()
        }
        return is_false
    }

    func func_textfield_placeholder(textfield:UITextField,placeholder_text:String) {
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder_text,
                                                             attributes: [NSAttributedStringKey.foregroundColor: color_gold])
    }
    
    
}





extension Credit_Debit_Card_ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if is_name_of_card {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if is_name_of_card {
            return arr_picker_name_of_card.count
        } else {
            if component == 0 {
                return arr_picker_month.count
            } else {
                return arr_picker_year.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if is_name_of_card {
            return arr_picker_name_of_card[row]
        } else {
            if component == 0 {
                return arr_picker_month[row]
            } else {
                return arr_picker_year[row]
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if is_name_of_card {
            txt_name_of_card.text = arr_picker_name_of_card[row]
            Model_credit_card.shared.card_type = arr_picker_name_of_card[row]
        } else {
            var exp_date = ""
            if component == 0 {
                exp_month_no = arr_picker_month_No[row]
            } else {
                exp_year = arr_picker_year[row]
            }
            exp_date = "\(exp_month_no) / \(exp_year)"
            txt_expiry_date.text = exp_date
        }
    }
    
}






