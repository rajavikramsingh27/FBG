//  asfTableViewCell.swift
//  FGB
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import CountryPicker
import KWVerificationCodeView

var isfrom_address = false

class Address_ViewController: UIViewController {
    @IBOutlet weak var tbl_address:UITableView!
    @IBOutlet weak var btn_save_changes:UIButton!
    @IBOutlet weak var txt_add_delivery_instruction:UITextView!
    @IBOutlet weak var view_add_delivery_instruction:UIView!
    
    @IBOutlet weak var lbl_add_delivery_instruction:UILabel!
    @IBOutlet weak var lbl_shipping_address:UILabel!
    
    @IBOutlet weak var nav_bar:UINavigationBar!
    
    var arr_place_holder = [String]()
    var arr_text_value = ["","","","Select Country","","","","",""]
    var arr_text_placeholder = ["Required","Required","Required","Required","Required","Required","Required","Required","Required"]
    
    var is_otp = false
    var is_otp_sent = false
    
    var str_default_CountryCode = ""
    var str_CountryCode = ""
    var str_code_view = ""
    var codeView: KWVerificationCodeView!
    
    @IBOutlet weak var picker: CountryPicker!
    @IBOutlet weak var view_CountryPicker: UIView!
    
    var str_add_delivery_instruction = ""
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    var country_VC = Country_ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_bar.topItem?.title = "address".localized
        
        str_add_delivery_instruction = "Providedetails".localized
        lbl_shipping_address.text = "thiswillbe".localized
        lbl_add_delivery_instruction.text = "delinstruction".localized
        btn_save_changes.setTitle("savechanges".localized, for: .normal)
        
        set_gradient_on_label(lbl: lbl_shipping_address)
        
        isfrom_address = true
        
        btn_save_changes.layer.cornerRadius = btn_save_changes.frame.size.height/2
        btn_save_changes.clipsToBounds = true
        
        func_get_customer_address()
        
        view_CountryPicker.isHidden = true
        
        view_CountryPicker.layer.cornerRadius = 6
        view_CountryPicker.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_get_country), name: NSNotification.Name (rawValue: "country"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(func_update_contry), name: NSNotification.Name (rawValue: "select_address"), object: nil)
        
        view_add_delivery_instruction.layer.cornerRadius = 2
        view_add_delivery_instruction.layer.borderColor = hexStringToUIColor(hex: "CFC25D").cgColor
        view_add_delivery_instruction.layer.borderWidth = 1
        view_add_delivery_instruction.clipsToBounds = true
    }
    
    @objc func func_get_country() {
//        if let country = UserDefaults.standard.object(forKey: "Country") as? String {
            arr_text_value[3] = Model_Address.shared.country_name
            tbl_address.reloadData()
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func func_with_OTP() {
        if is_otp {
            arr_place_holder = ["name","street","apartment","country","state","towncity","pincode","PhoneNumbers","OTP"]
        } else {
            arr_place_holder = ["name","street","apartment","country","state","towncity","pincode","PhoneNumbers"]
        }
        tbl_address.reloadData()
    }
    
    @IBAction func btn_save_changes(_ sender:Any) {
        if !func_validation() {
            return
        }
        
        func_update_address()
    }
    
    func func_get_customer_address() {
        DispatchQueue.main.async {
            self.func_ShowHud()
        }
        Model_Address.shared.func_get_customer_address { (status) in
            DispatchQueue.main.async {
                if status == "success" {
                    self.arr_text_value[0] = Model_Address.shared.shipping_name
                    self.arr_text_value[1] = Model_Address.shared.customer_address
                    self.arr_text_value[2] = Model_Address.shared.shipping_address2
                    self.arr_text_value[3] = Model_Address.shared.country_name
                    
                    self.arr_text_value[4] = Model_Address.shared.shipping_state
                    self.arr_text_value[5] =  Model_Address.shared.customer_city
                    self.arr_text_value[6] = Model_Address.shared.customer_postcode
                    self.arr_text_value[7] = Model_Address.shared.shipping_mobile
                    self.txt_add_delivery_instruction.text = Model_Address.shared.shipping_note
                    
                    self.func_AddCountryPicker()
                    self.str_CountryCode = Model_Address.shared.shipping_country_code
                    self.func_check_for_OTP()
                    self.func_with_OTP()
                } else {
                    self.func_get_country()
                }
                self.func_HideHud()
            }
        }
    }
    
    func func_update_address() {
        func_ShowHud()
        
        if txt_add_delivery_instruction.text ==  str_add_delivery_instruction {
            txt_add_delivery_instruction.text = ""
        }
        
        Model_Address.shared.shipping_note = txt_add_delivery_instruction.text!
        Model_Address.shared.shipping_name = arr_text_value[0]
        Model_Address.shared.customer_address = arr_text_value[1]
        Model_Address.shared.shipping_address2 = arr_text_value[2]
//        Model_Address.shared.customer_country = arr_text_value[3]
        
        Model_Address.shared.shipping_state = arr_text_value[4]
        Model_Address.shared.customer_city = arr_text_value[5]
        Model_Address.shared.customer_postcode = arr_text_value[6]
        
        if str_CountryCode.isEmpty {
            str_CountryCode = str_default_CountryCode
        }
        
        Model_Address.shared.shipping_mobile = "\(str_CountryCode)-\(arr_text_value[7])"
        
        Model_Address.shared.func_update_address { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Address.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Address.shared.str_message)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    NotificationCenter.default.post(name: NSNotification.Name (rawValue: "save_address"), object: nil)                    
                    self.func_HideHud()
                    if status == "success" {
                     self.dismiss(animated:true, completion: nil)
                    }
                })
            }
        }
    }
    
    func func_validation() -> Bool {
        var is_false = false
        
        if arr_text_value[0].isEmpty {
            func_ShowHud_Error(with: "name".localized)
            is_false = false
        } else if arr_text_value[1].isEmpty {
            func_ShowHud_Error(with: "street".localized)
            is_false = false
        } else if arr_text_value[2].isEmpty {
            func_ShowHud_Error(with: "apartment".localized)
            is_false = false
        } else if arr_text_value[3] == "country" {
            func_ShowHud_Error(with: "Enter Country".localized)
            is_false = false
        } else if arr_text_value[4].isEmpty {
            func_ShowHud_Error(with: "state".localized)
            is_false = false
        } else if arr_text_value[5].isEmpty {
            func_ShowHud_Error(with: "towncity".localized)
            is_false = false
        } else if arr_text_value[6].isEmpty {
            func_ShowHud_Error(with: "pincode".localized)
            is_false = false
        } else if arr_text_value[7].isEmpty {
            func_ShowHud_Error(with:"PhoneNumbers".localized)
            is_false = false
        } else if Model_Address.shared.shipping_country_code != str_CountryCode {
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



extension Address_ViewController : UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 8 {
            return 100
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_place_holder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell-1", for: indexPath) as! Address_OTP_TableViewCell
            
            if codeView != nil {
                codeView = nil
            }
            
            codeView = cell.codeView
            cell.codeView.delegate = self
            if is_otp_sent {
//                cell.btn_send_otp.setTitle("Re send", for: .normal)
                cell.btn_send_otp.isSelected = true
                cell.btn_verify_otp.isHidden = false
            } else {
//                cell.btn_send_otp.setTitle("Send", for: .normal)
                cell.btn_send_otp.isSelected = false
                cell.btn_verify_otp.isHidden = true
            }
            
            cell.btn_send_otp.addTarget(self, action: #selector(btn_send_otp(_:)), for: .touchUpInside)
            cell.btn_verify_otp.addTarget(self, action: #selector(btn_verify_otp(_:)), for: .touchUpInside)
            
            return cell
        } else if indexPath.row == 7 {
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
            var cell = Address_TableViewCell()
            if indexPath.row == 3 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell-3", for: indexPath) as! Address_TableViewCell
                if arr_text_value[indexPath.row].contains("Saudi Arabia") {
                    cell.img_flag.image = UIImage (named: "saudi.jpg")
                } else {
                    let flat_imag_name = "flag_\(arr_text_value[indexPath.row].replacingOccurrences(of:" ", with:"_").lowercased())"
                    print(flat_imag_name)
                    
                    if let path = Bundle.main.path(forResource:flat_imag_name, ofType: ".png") {
                        cell.img_flag.image = UIImage(contentsOfFile: path)
                    } else {
                        cell.img_flag.image = UIImage(named: "world.png")
                    }
                }
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Address_TableViewCell
            }
            
//            cell.txt_field.setPadding(left: 50, right: 50)
            
            cell.lbl_Title.text = arr_place_holder[indexPath.row].localized
            cell.txt_field.text = arr_text_value[indexPath.row]
            
            cell.txt_field.tag = indexPath.row
            cell.txt_field.delegate = self
            
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5 {
                cell.txt_field.keyboardType = .default
            } else {
                cell.txt_field.keyboardType = .numberPad
            }
            
            if let default_value = UserDefaults.standard.object(forKey: "Language") as? String {
                if default_value == "English" {
                    cell.txt_field.textAlignment = .left
                } else {
                    cell.txt_field.textAlignment = .right
                }
            } else {
                cell.txt_field.textAlignment = .right
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func btn_contry_code(_ sender:UIButton) {
        view_CountryPicker.isHidden = false
    }
    
    @IBAction func btn_send_otp(_ sender: UIButton) {
        if arr_text_value[7].isEmpty {
            func_ShowHud_Error(with: "entermobile".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                self.func_HideHud()
            })
            return
        } else if arr_text_value[7].count < 10 {
            func_ShowHud_Error(with: "phone_number_digis".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return
        }
        
        func_ShowHud()
        Model_Address.shared.mobile = "\(arr_text_value[7])"
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
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                    self.func_HideHud()
                })
                
                self.tbl_address.reloadData()
            }
        }
    }
    
    @IBAction func btn_verify_otp(_ sender: UIButton) {
        if str_code_view.isEmpty {
           self.func_ShowHud_Error(with:"enterotp".localized)
        } else if str_code_view == Model_Address.shared.str_message {
            Model_Address.shared.shipping_mobile = Model_Address.shared.mobile
            Model_Address.shared.shipping_country_code = Model_Address.shared.country_code
            
            self.func_ShowHud_Success(with:"verify".localized)
            self.is_otp = false
            self.func_with_OTP()
            
            let cell = tbl_address.dequeueReusableCell(withIdentifier: "cell-1") as! Address_OTP_TableViewCell
            cell.codeView = nil
            str_code_view = ""
        } else {
            self.func_ShowHud_Error(with:"otpnotmatch".localized)
        }
        DispatchQueue.main.asyncAfter(deadline:.now()+2, execute: {
            self.func_HideHud()
        })
    }
    
}

extension Address_ViewController:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        view_CountryPicker.isHidden = true
        
        if textField.tag == 3 {
            self.view.endEditing(true)
            self.country_VC = self.storyboard?.instantiateViewController(withIdentifier: "Country_ViewController") as! Country_ViewController
            self.view.addSubview(self.country_VC.view)
            self.addChildViewController(self.country_VC)
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        arr_text_value[textField.tag] = textField.text!
        
        let indexpath = IndexPath (row: textField.tag, section: 0)
        tbl_address.reloadRows(at: [indexpath], with: .none)
        
        func_check_for_OTP()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let ACCEPTABLE_CHARACTERS_address = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890._-,/ "
        
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
        } else if textField.tag == 1 || textField.tag == 2 || textField.tag == 4 || textField.tag == 5 {
            if textField.text!.count > 100 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_address).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else if textField.tag == 7 {
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



extension Address_ViewController:CountryPickerDelegate,KWVerificationCodeViewDelegate {
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
        if Model_Address.shared.shipping_mobile == arr_text_value[7] && Model_Address.shared.shipping_country_code == str_CountryCode {
            is_otp = false
        } else {
            is_otp = true
        }
        func_with_OTP()
    }
    
    @IBAction func btn_DoneCoutrnyPicker(_ sender: UIButton) {
        view_CountryPicker.isHidden = true
    }
    
    @IBAction func btn_CountryCode(_ sender: UIButton) {
        view_CountryPicker.isHidden = false
        self.view.endEditing(true)
    }
    
    func didChangeVerificationCode() {
        str_code_view = "\(codeView.getVerificationCode())"
        arr_text_value[8] = str_code_view
    }
    
}


extension Address_ViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == str_add_delivery_instruction {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = str_add_delivery_instruction
        }
    }
    
    @objc func func_update_contry() {
        func_ShowHud()
        Model_Country.shared.func_update_contry { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_get_country()
                    self.country_VC.view.removeFromSuperview()
                } else {
                    self.func_ShowHud_Error(with: Model_Country.shared.str_message)
                }
            }
        }
    }
    
}


