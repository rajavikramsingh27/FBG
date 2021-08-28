//
//  asdfTableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit
import CountryPickerView



class Settings_ViewController: UIViewController {
    @IBOutlet weak var tbl_setting:UITableView!

    @IBOutlet weak var nav_bar:UINavigationBar!
    @IBOutlet weak var btn_delete_your_ac:UIButton!
    @IBOutlet weak var lbl_version:UILabel!
    
    var arr_titles = [String]()
    var arr_titles_right = ["India","English","Currency","UK","Women","","",""]
    
    var timer_user_active =  Timer()
    
//    var cpvMain = CountryPickerView()
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    var country_VC = Country_ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nav_bar.applyNavGradient()
        
        isfrom_address=false
     
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_update_contry), name: NSNotification.Name (rawValue: "select_address"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nav_bar.topItem?.title = "settings".localized
        
        var app_version = ""
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            app_version = build
        }
        
        btn_delete_your_ac.setTitle("deleteaccount".localized, for: .normal)
        lbl_version.text = "\("version".localized) \(app_version) iOS"
        
        if Model_Walk_Through.shared.customer_social_id.isEmpty {
            arr_titles = ["country".localized,
                          "language".localized,
                          "sizes".localized,
                          "collection".localized,
                          "tnc".localized,
                          "about".localized,
                          "reset".localized]
        } else {
            arr_titles = ["country".localized,"language".localized,"sizes".localized,"collection".localized,"tnc".localized,"about".localized]
        }
        tbl_setting.reloadData()
        timer_user_active = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(func_reload), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer_user_active.invalidate()
    }
    
    @objc func func_reload() {
        tbl_setting.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func func_delete_account() {
        func_ShowHud()
        Model_setting.shared.func_delete_account { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_setting.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        self.func_HideHud()
                        UserDefaults.standard.removeObject(forKey: "login_Data")
                        UserDefaults.standard.removeObject(forKey: "filter")
                        
                        let login_VC = self.storyboard?.instantiateViewController(withIdentifier: "Login_ViewController")
                        self.present(login_VC!, animated: true, completion: nil)
                    })
                } else {
                    self.func_ShowHud_Error(with: Model_setting.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        self.func_HideHud()
                    })
                }
            }
        }
    }
    
    @IBAction func btn_Delete_ac(_ sender:Any) {
        let alert = UIAlertController (title:"warning".localized, message: "deletewaring".localized, preferredStyle: .alert)
        let yes = UIAlertAction(title: "cancel".localized, style: .cancel) { (yes) in
            
        }
        
        let no = UIAlertAction(title: "delete".localized, style: .default) { (yes) in
            self.func_delete_account()
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        
//        alert.view.tintColor = UIColor .black
        present(alert, animated: true, completion: nil)
    }

    
}




//  MARK:- UICollectionView methods

extension Settings_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Settigns_TableViewCell
        
        cell.lbl_title.text = arr_titles[indexPath.row]
        
//        var currency_symbol = ""
        var country_name = ""
        set_gradient_on_label(lbl: cell.lbl_title)
        
        var flat_imag_name = ""
        
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            currency_symbol = "\(dict_LoginData["currency_symbol"] ?? "")"
            country_name = "\(dict_LoginData["country_name"] ?? "")"
            
            flat_imag_name = "flag_\(country_name.replacingOccurrences(of:" ", with:"_").lowercased())"
        }
        
        if indexPath.row == 0 {
            cell.img_flag.isHidden = false
            cell.lbl_title_right.text = country_name
            
            if let path = Bundle.main.path(forResource:flat_imag_name, ofType: ".png") {
                cell.img_flag.image = UIImage(contentsOfFile: path)
            }else if flat_imag_name == "flag_saudi_arabia_"{
                cell.img_flag.image = UIImage(named: "flag_saudi_arabia.png")

            } else {
                cell.img_flag.image = UIImage(named: "world.png")
            }
            
        } else if indexPath.row == 1 {
            cell.img_flag.isHidden = true
            if let default_value = UserDefaults.standard.object(forKey: "Language") as? String {
                cell.lbl_title_right.text = default_value
            } else {
                cell.lbl_title_right.text = arr_titles_right[indexPath.row]
            }
        } else if indexPath.row == 2 {
            cell.img_flag.isHidden = true
            if let default_value = UserDefaults.standard.object(forKey: "Sizes") as? String {
                cell.lbl_title_right.text = default_value.uppercased()
            } else {
                cell.lbl_title_right.text = arr_titles_right[indexPath.row]
            }
        } else if indexPath.row == 3 {
            cell.img_flag.isHidden = true
            if let default_value = UserDefaults.standard.object(forKey: "Collection") as? String {
                cell.lbl_title_right.text = default_value.uppercased()
            } else {
                cell.lbl_title_right.text = arr_titles_right[indexPath.row]
            }
        } else {
            cell.img_flag.isHidden = true
            cell.lbl_title_right.text = arr_titles_right[indexPath.row]
            cell.lbl_title_right.isHidden = true
        }
        
        set_gradient_on_label(lbl: cell.lbl_title_right)
        set_gradient_on_label(lbl: cell.lbl_title_right)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
         if indexPath.row == 0 {
            is_from_login_sign = false
            self.country_VC = self.storyboard?.instantiateViewController(withIdentifier: "Country_ViewController") as! Country_ViewController
            self.view.addSubview(self.country_VC.view)
            self.addChildViewController(self.country_VC)
         } else if indexPath.row == 1 {
            str_title_Curr_Coll_Lang_Size = "language".localized
            arr_Curr_Coll_Lang_Size = ["English","عربى"]
            func_present_Curr_Coll_Lang_Size_VC()
         } else if indexPath.row == 2 {
            str_title_Curr_Coll_Lang_Size = "sizes".localized
            arr_Curr_Coll_Lang_Size = ["US","EU","UK"]
            func_present_Curr_Coll_Lang_Size_VC()
        } else if indexPath.row == 3 {
            str_title_Curr_Coll_Lang_Size = "collection".localized
            arr_Curr_Coll_Lang_Size = ["Women".localized,"Men".localized,"Kids".localized]
            func_present_Curr_Coll_Lang_Size_VC()
        } else if indexPath.row == 4 {
            str_help_selected = termN_conditions
            str_title = "tnc".localized
//            func_present_About_Terms_Cond_VC()
            func_help()
        } else if indexPath.row == 5 {
            str_help_selected = about_help
            str_title = "about".localized
            func_help()
//            func_present_About_Terms_Cond_VC()
         } else if indexPath.row == 6 {
            let reset_VC = self.storyboard?.instantiateViewController(withIdentifier: "Reset_Password_ViewController") as! Reset_Password_ViewController
            self.present(reset_VC, animated: true, completion: nil)
        }
        
        
        
    }
    
    func func_help() {
        let help_VC = storyboard?.instantiateViewController(withIdentifier: "Help_ViewController") as! Help_ViewController
        present(help_VC, animated: true, completion: nil)
    }
    
    func func_present_Curr_Coll_Lang_Size_VC() {
        let curr_coll_lang = storyboard?.instantiateViewController(withIdentifier: "Curr_Coll_Lang_Size_ViewController") as! Curr_Coll_Lang_Size_ViewController
        present(curr_coll_lang, animated: true, completion: nil)
    }
    
    func func_present_About_Terms_Cond_VC() {
        let curr_coll_lang = storyboard?.instantiateViewController(withIdentifier: "About_Terms_Cond_ViewController") as! About_Terms_Cond_ViewController
        present(curr_coll_lang, animated: true, completion: nil)
    }
    
}



extension Settings_ViewController: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        // Only countryPickerInternal has it's delegate set
        let title = "Selected Country"
        let message = "Name: \(country.name) \nCode: \(country.code) \nPhone: \(country.phoneCode)"
        print(message)
    }
    
    @objc func func_update_contry() {
        func_ShowHud()
        Model_Country.shared.func_update_contry { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.country_VC.view.removeFromSuperview()
                    self.tbl_setting.reloadData()
                } else {
                    self.func_ShowHud_Error(with: Model_Country.shared.str_message)
                }
            }
        }
    }
}


