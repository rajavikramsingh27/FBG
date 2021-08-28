
//  Country_ViewController.swift
//  FGB

//  Created by iOS-Appentus on 13/03/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit
import CountryPickerView



class Country_ViewController: UIViewController {
    @IBOutlet weak var tbl_country:UITableView!
    @IBOutlet weak var lbl_select_contry:UILabel!
    
//    @IBOutlet weak var btn_done:UIButton!
    
    var cpvMain = CountryPickerView()
    
    var arr_selected = [Bool]()
    
    var timer_user_active =  Timer()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_select_contry.text = "select_country".localized
        
        Model_Country.shared.arr_get_country.removeAll()
        func_get_country()
        // Do any additional setup after loading the view.
//        set_grad_to_btn(btn: btn_done)
        timer_user_active = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(func_set_data), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer_user_active.invalidate()
    }
    
    @objc func func_set_data() {
        for _ in 0..<Model_Country.shared.arr_get_country.count {
            arr_selected.append(false)
        }
        
        var country_name = ""
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            country_name = "\(dict_LoginData["country_name"] ?? "")"
            
            for i in 0..<Model_Country.shared.arr_get_country.count {
                let model = Model_Country.shared.arr_get_country[i]
                if country_name.uppercased() == model.country_name.uppercased() {
                    arr_selected[i] = true
                } else {
                    arr_selected[i] = false
                }
            }
        }
        tbl_country.reloadData()
    }
    
    func func_get_country() {
        DispatchQueue.main.async {
            self.func_ShowHud()
        }
        Model_Country.shared.func_get_country { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    self.func_set_data()
                } else {
                    self.func_ShowHud_Error(with: Model_Country.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                })
                self.tbl_country.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
}



extension Country_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Country.shared.arr_get_country.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = Model_Country.shared.arr_get_country[indexPath.row]
        
        var cell = Country_TableViewCell()
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Country_TableViewCell
            cell.img_flag.image = UIImage (named: "saudi.jpg")
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell-1", for: indexPath) as! Country_TableViewCell
            
            let flat_imag_name = "flag_\(model.country_name.replacingOccurrences(of:" ", with:"_").lowercased())"
            print(flat_imag_name)
            
            if let path = Bundle.main.path(forResource:flat_imag_name, ofType: ".png") {
                cell.img_flag.image = UIImage(contentsOfFile: path)
            } else {
                cell.img_flag.image = UIImage(named: "world.png")
            }
            
        }
        
        cell.lbl_name_country.text = model.country_name
        
        cell.btn_select.tag = indexPath.row
        cell.btn_select.addTarget(self, action: #selector(btn_select(_:)), for: .touchUpInside)
        
        if arr_selected[indexPath.row] {
            cell.btn_select.isSelected = true
        } else {
            cell.btn_select.isSelected = false
        }
        
        set_gradient_on_label(lbl: cell.lbl_name_country)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        func_selected(index: indexPath.row)
    }
    
    @IBAction func btn_select(_ sender:UIButton) {
        func_selected(index: sender.tag)
    }
    
    @IBAction func btn_done(_ sender:UIButton) {
        self.view.removeFromSuperview()
    }
    
    func func_selected(index:Int) {
        let model = Model_Country.shared.arr_get_country[index]
        Model_Country.shared.country_id = model.country_id
        Model_Address.shared.country_name = model.country_name
        Model_Address.shared.customer_country = model.country_id
        
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            var dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            dict_LoginData["customer_country"] = model.country_name
            dict_LoginData["country_tax_name"] = model.country_tax_name
            dict_LoginData["country_tax"] = model.country_tax
            dict_LoginData["country_name"] = model.country_name
            
            Model_Country.shared.currency = "\(dict_LoginData["currency_id"]!)"
            
            let data_dict_Result = NSKeyedArchiver.archivedData(withRootObject: dict_LoginData)
            UserDefaults .standard .setValue(data_dict_Result, forKey: "login_Data")
        }
        
        for i in 0..<Model_Country.shared.arr_get_country.count {
            if i == index {
                arr_selected[i] = true
            } else {
                arr_selected[i] = false
            }
        }
        
        tbl_country.reloadData()
        
        if isfrom_address {
            NotificationCenter.default.post(name: NSNotification.Name (rawValue: "country"), object: nil)
            self.view.removeFromSuperview()
        } else {
            NotificationCenter.default.post(name: NSNotification.Name (rawValue: "select_address"), object: nil)
        }
        
    }
    
}




