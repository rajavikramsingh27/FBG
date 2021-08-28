
//  Curr_Coll_Lang_Size_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

var arr_Curr_Coll_Lang_Size = [String]()
var str_title_Curr_Coll_Lang_Size = ""

class Curr_Coll_Lang_Size_ViewController: UIViewController {
    @IBOutlet weak var tbl_Curr_Coll_Lang_Size:UITableView!
    @IBOutlet weak var nav_bar:UINavigationBar!
    
    var arr_selected = [Bool]()
    
    var timer_user_active =  Timer()
    
    var is_reload_currency = false
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_bar.applyNavGradient()
        nav_bar.topItem?.title = str_title_Curr_Coll_Lang_Size
        
        if str_title_Curr_Coll_Lang_Size == "Currency" {
            func_get_currency()
        } else {
            func_reload()
        }
        
        timer_user_active = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(func_reload), userInfo: nil, repeats: true)
    }
    
    func func_selected() {
        arr_selected.removeAll()
        for _ in 0..<arr_Curr_Coll_Lang_Size.count {
            arr_selected.append(false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tbl_Curr_Coll_Lang_Size.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer_user_active.invalidate()
    }
    
    @objc func func_reload() {
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
//            print(dict_LoginData)
            
            currency_symbol = "\(dict_LoginData["currency_symbol"] ?? "")"
            Model_setting.shared.customer_currency = "\(dict_LoginData["customer_currency"] ?? "")"
        }
        
        if str_title_Curr_Coll_Lang_Size == "language".localized {
            func_selected()
            if let default_value = UserDefaults.standard.object(forKey: "Language") as? String {
                for i in 0..<arr_selected.count {
                    if default_value == arr_Curr_Coll_Lang_Size[i] {
                        arr_selected[i] = true
                    } else {
                        arr_selected[i] = false
                    }
                }
            }
        } else if str_title_Curr_Coll_Lang_Size == "currency".localized {
//            func_get_currency()
            func_set_currency()
        } else if str_title_Curr_Coll_Lang_Size == "sizes".localized {
            func_selected()
            
            if let default_value = UserDefaults.standard.object(forKey: "Sizes") as? String {
                for i in 0..<arr_selected.count {
                    if default_value.lowercased() == arr_Curr_Coll_Lang_Size[i].lowercased() {
                        arr_selected[i] = true
                    } else {
                        arr_selected[i] = false
                    }
                }
            }
        } else if str_title_Curr_Coll_Lang_Size == "collection".localized {
            func_selected()
            
            if let default_value = UserDefaults.standard.object(forKey: "Collection") as? String {
                for i in 0..<arr_selected.count {
                    if default_value.lowercased() == arr_Curr_Coll_Lang_Size[i].lowercased() {
                        arr_selected[i] = true
                    } else {
                        arr_selected[i] = false
                    }
                }
            }
        }
        tbl_Curr_Coll_Lang_Size.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func func_get_currency() {
        DispatchQueue.main.async {
            self.func_ShowHud()
        }
        
        Model_Currency.shared.func_get_currency { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    self.arr_selected.removeAll()
                    for _ in 0..<Model_Currency.shared.arr_get_currency.count {
                        self.arr_selected.append(false)
                    }
                    
                    for i in 0..<self.arr_selected.count {
                        if currency_idd == Model_Currency.shared.arr_get_currency[i].currency_id {
                            self.arr_selected[i] = true
                        } else {
                            self.arr_selected[i] = false
                        }
                    }
                    self.tbl_Curr_Coll_Lang_Size.reloadData()
                } else {
                    self.func_ShowHud_Error(with: Model_Currency.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                })
            }
        }
    }
    
    func func_set_currency() {
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            currency_idd = "\(dict_LoginData["currency_id"] ?? "")"
        }
        
        self.arr_selected.removeAll()
        for _ in 0..<Model_Currency.shared.arr_get_currency.count {
            self.arr_selected.append(false)
        }
        
        for i in 0..<self.arr_selected.count {
            if currency_idd == Model_Currency.shared.arr_get_currency[i].currency_id {
                self.arr_selected[i] = true
            } else {
                self.arr_selected[i] = false
            }
        }
    }
    
    func func_update_setting() {
        func_ShowHud()
        Model_setting.shared.func_update_setting { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {                    
                    self.func_ShowHud_Success(with: Model_setting.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_setting.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    if status == "success" {
                        self.dismiss(animated: true, completion: nil)
                    }
                    self.func_HideHud()
                })
            }
        }
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }

}




//  MARK:- UITableViewDelegate methods

extension Curr_Coll_Lang_Size_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_selected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Curr_Coll_Lang_Size_TableViewCell
        
        if arr_selected[indexPath.row] {
            cell.btn_check.isSelected = true
        } else {
            cell.btn_check.isSelected = false
        }
        
        if str_title_Curr_Coll_Lang_Size == "Currency" {
            let model = Model_Currency.shared.arr_get_currency[indexPath.row]
            cell.lbl_title.text = model.currency_name
        } else {
            if str_title_Curr_Coll_Lang_Size == "Collection" {
                cell.lbl_title.text = arr_Curr_Coll_Lang_Size[indexPath.row].localized
            } else {
                cell.lbl_title.text = arr_Curr_Coll_Lang_Size[indexPath.row]
            }
        }
        
        cell.btn_check.tag = indexPath.row
        cell.btn_check.addTarget(self, action: #selector(btn_check(_:)), for: .touchUpInside)
        set_gradient_on_label(lbl: cell.lbl_title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func btn_check(_ sender:UIButton) {
        if str_title_Curr_Coll_Lang_Size == "language".localized {
            UserDefaults.standard.set("\(arr_Curr_Coll_Lang_Size[sender.tag])", forKey: "Language")
            
            let language_VC = storyboard?.instantiateViewController(withIdentifier: "Language_ViewController") as! Language_ViewController
            present(language_VC, animated: true, completion: nil)
        } else if str_title_Curr_Coll_Lang_Size == "Currency" {
            let model = Model_Currency.shared.arr_get_currency[sender.tag]
            
            Model_setting.shared.customer_currency = model.currency_id
            Model_setting.shared.customer_currency_name = model.currency_name
            Model_setting.shared.currency_prices = model.currency_price
//            Model_setting.shared.currency_symbols = model.currency_symbol
//            UserDefaults.standard.set("\(model.currency_name)", forKey: "Currency")
            
            func_update_setting()
        } else if str_title_Curr_Coll_Lang_Size == "sizes".localized {
            UserDefaults.standard.set("\(arr_Curr_Coll_Lang_Size[sender.tag])", forKey: "Sizes")
            func_update_setting()
        } else if str_title_Curr_Coll_Lang_Size == "collection".localized {
            UserDefaults.standard.set("\(arr_Curr_Coll_Lang_Size[sender.tag])", forKey: "Collection")
            func_update_setting()
        }
        
        for i in 0..<arr_selected.count {
            if i == sender.tag {
                arr_selected[i] = true
            } else {
                arr_selected[i] = false
            }
        }
        
        tbl_Curr_Coll_Lang_Size.reloadData()
    }
    
}




