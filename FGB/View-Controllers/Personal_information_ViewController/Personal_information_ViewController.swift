//  PTableViewCell.swift
//  FGB
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import KWVerificationCodeView
import CountryPicker


class Personal_information_ViewController: UIViewController {
    @IBOutlet weak var tbl_personal_info:UITableView!
    
    @IBOutlet weak var btn_male:UIButton!
    @IBOutlet weak var btn_female:UIButton!
    
    @IBOutlet weak var btn_save_changes:UIButton!
    
    @IBOutlet weak var view_date_picker_container:UIView!
    
    @IBOutlet weak var nav_bar:UINavigationBar!
    
    var str_customer_gender = ""
    
    var arr_place_holder = [String]()
    var arr_text_value = ["","","","","","",""]
    
    var is_otp = false
    var is_otp_sent = false
    
    var str_CountryCode = ""
    var str_old_CountryCode = ""
    var str_default_CountryCode = ""
    var str_code_view = ""
    var str_code_Old_view = ""
    var codeView: KWVerificationCodeView!
    
    @IBOutlet weak var picker: CountryPicker!
    @IBOutlet weak var view_CountryPicker: UIView!
    
    @IBOutlet weak var lbl_male: UILabel!
    @IBOutlet weak var lbl_fe_male: UILabel!
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isfrom_address = false
        
        set_gradient_on_label(lbl: lbl_male)
        set_gradient_on_label(lbl: lbl_fe_male)
        
        nav_bar.topItem?.title = "PersonalInfo".localized
        btn_save_changes.setTitle("savechanges".localized, for: .normal)
        
        lbl_male.text = "male".localized
        lbl_fe_male.text = "female".localized
        
        btn_save_changes.layer.cornerRadius = btn_save_changes.frame.size.height/2
        btn_save_changes.clipsToBounds = true
        
        view_date_picker_container.isHidden = true
        view_CountryPicker.isHidden = true
        
        view_date_picker_container.layer.cornerRadius = 6
        view_date_picker_container.clipsToBounds = true
        
        view_CountryPicker.layer.cornerRadius = 6
        view_CountryPicker.clipsToBounds = true
        
        self.func_AddCountryPicker()
        func_set_data()
        func_with_OTP()
    }
    
    func func_set_data() {
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            arr_text_value[0] = "\(dict_LoginData["customer_fname"]!)"
            arr_text_value[1] = "\(dict_LoginData["customer_lname"]!)"
            arr_text_value[2] = "\(dict_LoginData["customer_email"]!)"
            arr_text_value[3] = "\(dict_LoginData["customer_dob"]!)"
            let arr_customer_mobile = "\(dict_LoginData["customer_mobile"]!)".components(separatedBy: "-")
            
            if arr_customer_mobile.count > 0 {
                str_CountryCode = arr_customer_mobile[0]
                str_old_CountryCode = str_CountryCode
            }
            
            if arr_customer_mobile.count > 1 {
                arr_text_value[4] = arr_customer_mobile[1]
                Model_personal_info.shared.customer_mobile = arr_text_value[4]
            }
            
            let customer_gender = "\(dict_LoginData["customer_gender"]!)"
            str_customer_gender = customer_gender
            
            if customer_gender == "Male" {
                btn_male.isSelected = true
                btn_female.isSelected = false
            } else if customer_gender == "Female" {
                btn_male.isSelected = false
                btn_female.isSelected = true
            }
            func_check_for_OTP()
            tbl_personal_info.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_done_date_picker(_ sender:UIButton) {
        view_date_picker_container.isHidden = true
    }
    
    @IBAction func btn_date_picker(_ sender:UIDatePicker) {
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = -18
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        
        components.year = -50
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        sender.minimumDate = minDate
        sender.maximumDate = maxDate
        
        let date_selected = sender.date
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "dd MMM yyyy"
        
        arr_text_value[3] = date_formatter.string(from: date_selected)
        
        let indexpath = IndexPath (row: 3, section: 0)
        tbl_personal_info.reloadRows(at: [indexpath], with: .none)
    }
    
    @IBAction func btn_male(_ sender:Any) {
        btn_male.isSelected = true
        btn_female.isSelected = false
        str_customer_gender = "Male"
    }
    
    @IBAction func btn_female(_ sender:Any) {
        btn_male.isSelected = false
        btn_female.isSelected = true
        str_customer_gender = "Female"
    }
    
    @IBAction func btn_save_changes(_ sender:Any) {
        if !func_validation() {
            return
        }
        
        func_update_personal_info()
    }
    
    func func_update_personal_info() {
        func_ShowHud()
        
        Model_personal_info.shared.fname = arr_text_value[0]
        Model_personal_info.shared.lname = arr_text_value[1]
        Model_personal_info.shared.customer_email = arr_text_value[2]
        Model_personal_info.shared.customer_dob = arr_text_value[3]
        if str_CountryCode.isEmpty {
            str_CountryCode = str_old_CountryCode
        }
        Model_personal_info.shared.customer_mobile = "\(str_CountryCode)-\(arr_text_value[4])"
        
        Model_personal_info.shared.customer_gender = str_customer_gender
        
        Model_personal_info.shared.func_update_personal_info { (status) in
            DispatchQueue.main.async {
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_personal_info.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_personal_info.shared.str_message)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                    self.func_HideHud()
                    self.dismiss(animated: true, completion: nil)
                })
                self.func_HideHud()
            }
        }
    }
    
    func func_validation() -> Bool {
        let is_email_valid = func_IsValidEmail(testStr: arr_text_value[2])
        var is_false = false
        if arr_text_value[0].isEmpty {
            func_ShowHud_Error(with: "Enter first name".localized)
            is_false = false
        } else if arr_text_value[1].isEmpty {
            func_ShowHud_Error(with: "Enter last name".localized)
            is_false = false
        } else if arr_text_value[2].isEmpty {
            func_ShowHud_Error(with: "Enter email".localized)
            is_false = false
        } else if !is_email_valid {
            func_ShowHud_Error(with: "Enter a valid email".localized)
            is_false = false
        }  else if arr_text_value[3].isEmpty {
            func_ShowHud_Error(with: "enterdob".localized)
            is_false = false
        } else if arr_text_value[4].isEmpty {
            func_ShowHud_Error(with: "entermobile".localized)
            is_false = false
        }  else if arr_text_value[4].count < 10 {
            func_ShowHud_Error(with: "phone_number_digis".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        }else if str_customer_gender.isEmpty {
            func_ShowHud_Error(with: "selectgender".localized)
            is_false = false
        }  else if Model_Address.shared.shipping_country_code != str_CountryCode {
            if str_code_view == Model_Address.shared.str_message {
                is_false = true
            } else {
                func_ShowHud_Error(with: "verify".localized)
                is_false = false
            }
        } else {
            is_false = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.func_HideHud()
        }
        return is_false
    }
    
}



extension Personal_information_ViewController : UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 {
            return 100
        } else {
            return 75
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_place_holder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell-1", for: indexPath) as! Address_OTP_TableViewCell
            
            if codeView != nil {
                codeView = nil
            }
            codeView = cell.codeView
            cell.codeView.delegate = self
            
            if is_otp_sent {
                cell.btn_send_otp.setTitle("send".localized, for: .normal)
                cell.btn_verify_otp.isHidden = false
            } else {
                cell.btn_send_otp.setTitle("resendotp".localized, for: .normal)
                cell.btn_verify_otp.isHidden = true
            }
            
            cell.btn_send_otp.addTarget(self, action: #selector(btn_send_otp(_:)), for: .touchUpInside)
            cell.btn_verify_otp.addTarget(self, action: #selector(btn_verify_otp(_:)), for: .touchUpInside)
            
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell-2", for: indexPath) as! Address_Mobile_TableViewCell
            
            if let default_value = UserDefaults.standard.object(forKey: "Language") as? String {
                if default_value == "English" {
                    cell.txt_field.textAlignment = .left
                } else {
                    cell.txt_field.textAlignment = .right
                }
            } else {
                cell.txt_field.textAlignment = .right
            }
            
            cell.lbl_title.text = arr_place_holder[indexPath.row].localized
            cell.txt_field.text = arr_text_value[indexPath.row]
            
            cell.txt_field.tag = indexPath.row
            cell.txt_field.delegate = self
            cell.txt_field.keyboardType = .numberPad
            
            if str_CountryCode.isEmpty {
                cell.btn_country_code.setTitle(str_default_CountryCode, for: .normal)
            } else {
                cell.btn_country_code.setTitle(str_CountryCode, for: .normal)
            }
            
            cell.btn_country_code.tag = indexPath.row
            cell.btn_country_code.addTarget(self, action: #selector(btn_contry_code(_:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Personal_information_TableViewCell
            
            if let default_value = UserDefaults.standard.object(forKey: "Language") as? String {
                if default_value == "English" {
                    cell.txt_field.textAlignment = .left
                } else {
                    cell.txt_field.textAlignment = .right
                }
            } else {
                cell.txt_field.textAlignment = .right
            }
            
            cell.lbl_title.text = arr_place_holder[indexPath.row].localized
            cell.txt_field.text = arr_text_value[indexPath.row]
            
            cell.txt_field.tag = indexPath.row
            cell.txt_field.delegate = self
            
            if indexPath.row == 2 {
                cell.txt_field.keyboardType = .emailAddress
                cell.txt_field.isUserInteractionEnabled = false
            } else if indexPath.row == 3 {
                cell.txt_field.keyboardType = .phonePad
                cell.txt_field.isUserInteractionEnabled = true
            } else {
                cell.txt_field.keyboardType = .default
                cell.txt_field.isUserInteractionEnabled = true
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func btn_contry_code(_ sender:UIButton) {
        view_CountryPicker.isHidden = false
        view_date_picker_container.isHidden = true
        self.view.endEditing(true)
    }
    
    @IBAction func btn_send_otp(_ sender: UIButton) {
        if arr_text_value[4].isEmpty {
            func_ShowHud_Error(with: "entermobile".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                self.func_HideHud()
            })
            return
        } else if arr_text_value[4].count < 10 {
            func_ShowHud_Error(with: "phone_number_digis".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return 
        }
        
        func_ShowHud()
        Model_Address.shared.mobile = "\(arr_text_value[4])"
        if str_CountryCode.isEmpty {
            str_CountryCode = str_default_CountryCode
        }
        Model_Address.shared.country_code = "\(str_CountryCode)"
        
        Model_Address.shared.func_send_otp { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    let sendotp = "sendotp".localized
                    self.func_ShowHud_Success(with: "\(sendotp) :- "+Model_Address.shared.str_message)
                    self.is_otp_sent = true
                } else {
                    self.func_ShowHud_Error(with: Model_Address.shared.str_message)
                    self.is_otp_sent = false
                }
                
                DispatchQueue.main.asyncAfter(deadline:.now()+2, execute: {
                    self.func_HideHud()
                    self.tbl_personal_info.reloadData()
                })
            }
        }
    }
    
    
    
    @IBAction func btn_verify_otp(_ sender: UIButton) {
        if str_CountryCode.isEmpty {
            self.func_ShowHud_Error(with:"enterotp".localized)
        } else if str_code_view == Model_Address.shared.str_message {
            self.func_ShowHud_Success(with:"verify".localized)
            self.is_otp = false
            
            Model_personal_info.shared.customer_mobile = Model_Address.shared.mobile
            arr_text_value[4] = Model_Address.shared.mobile
            str_CountryCode = Model_Address.shared.country_code
            str_old_CountryCode = Model_Address.shared.country_code
            
            self.func_with_OTP()
        } else {
            self.func_ShowHud_Error(with:"otpnotmatch".localized)
        }
        DispatchQueue.main.asyncAfter(deadline:.now()+2, execute: {
            self.func_HideHud()
        })
    }
    
    
    
}



extension Personal_information_ViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            view_CountryPicker.isHidden = true
            view_date_picker_container.isHidden = false
            self.view.endEditing(true)
            return false
        } else {
            view_date_picker_container.isHidden = true
            view_CountryPicker.isHidden = true
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        arr_text_value[textField.tag] = textField.text!
        
        let indexpath = IndexPath (row: textField.tag, section: 0)
        tbl_personal_info.reloadRows(at: [indexpath], with: .none)
        
        func_check_for_OTP()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        
        if textField.tag == 0 {
            if textField.text!.count > 31 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else if textField.tag == 1 {
            if textField.text!.count > 31 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else if textField.tag == 2 {
            if textField.text!.count > 31 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: email_ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else if textField.tag == 4 {
            if textField.text!.count > 15 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
}



extension Personal_information_ViewController:CountryPickerDelegate,KWVerificationCodeViewDelegate {
    func func_AddCountryPicker() {
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        let theme = CountryViewTheme(countryCodeTextColor: .black, countryNameTextColor: .black, rowBackgroundColor: .white, showFlagsBorder: false)
        picker.theme = theme
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(code!)
    }
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        str_CountryCode = phoneCode
        str_default_CountryCode = phoneCode
        func_check_for_OTP()
    }
    
    func func_check_for_OTP() {
        if Model_personal_info.shared.customer_mobile == arr_text_value[4] && str_old_CountryCode == str_CountryCode {
            is_otp = false
        } else {
            is_otp = true
        }
        func_with_OTP()
    }
    
    @IBAction func btn_DoneCoutrnyPicker(_ sender: UIButton) {
        view_CountryPicker.isHidden = true
    }
    
//    @IBAction func btn_CountryCode(_ sender: UIButton) {
//        view_CountryPicker.isHidden = false
//        view_date_picker_container.isHidden = true
//        self.view.endEditing(true)
//    }
    
    func didChangeVerificationCode() {
        str_code_view = "\(codeView.getVerificationCode())"
        arr_text_value[5] = str_code_view
    }
    
    func func_with_OTP() {
        if is_otp {
            arr_place_holder =  ["first","last","email","dob","PhoneNumbers","OTP"]
            is_otp_sent = false
            let cell = tbl_personal_info.dequeueReusableCell(withIdentifier: "cell-1") as! Address_OTP_TableViewCell
            cell.codeView = nil
            str_code_view = ""
        } else {
            arr_place_holder = ["first","last","email","dob","PhoneNumbers"]
            is_otp_sent = true
        }
        tbl_personal_info.reloadData()
    }
    
}

