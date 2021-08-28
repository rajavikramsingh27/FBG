//  Filter_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import WARangeSlider



var dict_filter = [
    "category_code":"0",
    "subcate_code":"0",
    "category_name":"All",
    "subcate_name":"All",
    "size":"All",
    "color":"All",
    "mini_price":"10",
    "max_price":"5000",
    "sort_type":"All"
]


class Filter_ViewController: UIViewController {
    @IBOutlet weak var btn_apply:UIButton!
    
    @IBOutlet weak var view_picker_container:UIView!
    @IBOutlet weak var picker_view:UIPickerView!
    
    @IBOutlet weak var range_slider:RangeSlider!
    
    @IBOutlet weak var lbl_size:UILabel!
    @IBOutlet weak var lbl_product_type:UILabel!
    @IBOutlet weak var lbl_sub_product_type:UILabel!
    @IBOutlet weak var lbl_colour:UILabel!
    
//    @IBOutlet weak var lbl_price_min:UILabel!
//    @IBOutlet weak var lbl_price_max:UILabel!
    @IBOutlet weak var lbl_sort:UILabel!
    
    @IBOutlet weak var lbl_min_price:UILabel!
    @IBOutlet weak var lbl_max_price:UILabel!
    
    @IBOutlet weak var hieght_sub_products:NSLayoutConstraint!
    @IBOutlet weak var hieght_color:NSLayoutConstraint!
    @IBOutlet weak var hieght_size:NSLayoutConstraint!
    
    @IBOutlet weak var top_sub_products:NSLayoutConstraint!
    @IBOutlet weak var top_color:NSLayoutConstraint!
    @IBOutlet weak var top_size:NSLayoutConstraint!
    
    @IBOutlet weak var view_sub_products:UIView!
    @IBOutlet weak var view_color:UIView!
    @IBOutlet weak var view_size:UIView!
    
    @IBOutlet weak var product_type_lbl: UILabel!
    @IBOutlet weak var sub_product_type_lbl: UILabel!
    @IBOutlet weak var size_lbl: UILabel!
    @IBOutlet weak var color_lbl: UILabel!
    @IBOutlet weak var price_lbl: UILabel!
    @IBOutlet weak var sort_lbl: UILabel!
    
    @IBOutlet weak var btn_done: UIButton!
    @IBOutlet weak var btn_clear_all: UIButton!

    @IBOutlet weak var nav_bar: UINavigationBar!
    
    var arr_picker = [String]()
    
    var index = -1
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_picker_container.isHidden = true
        btn_apply.layer.cornerRadius = btn_apply.frame.size.height/2
        btn_apply.clipsToBounds = true
        
        view_picker_container.layer.cornerRadius = 6
        view_picker_container.clipsToBounds = true
        
        func_set_filter_value()
        func_category_subcate()
        
        set_gradient_on_label(lbl: product_type_lbl)
        set_gradient_on_label(lbl: sub_product_type_lbl)
        set_gradient_on_label(lbl: size_lbl)
        set_gradient_on_label(lbl: color_lbl)
        set_gradient_on_label(lbl: price_lbl)
        set_gradient_on_label(lbl: sort_lbl)
        
        product_type_lbl.text = "producttype".localized
        sub_product_type_lbl.text = "subproducttype".localized
        size_lbl.text = "sizes".localized
        color_lbl.text = "color".localized
        price_lbl.text = "price".localized
        sort_lbl.text = "sort".localized
        btn_done.setTitle("done".localized, for: .normal)
        btn_clear_all.setTitle("clear".localized, for: .normal)
        nav_bar.topItem?.title = "filter".localized
    }
    
    func func_set_filter_value() {
        lbl_product_type.text = "\(dict_filter["category_name"] ?? "")"
        lbl_sub_product_type.text = "\(dict_filter["subcate_name"] ?? "")"
        lbl_size.text = "\(dict_filter["size"] ?? "")"
        lbl_colour.text = "\(dict_filter["color"] ?? "")"
        lbl_sort.text = "\(dict_filter["sort_type"] ?? "")"
        
//        lbl_min_price.text = "\(dict_filter["mini_price"] ?? "") \(currency_symbol)"
//        lbl_max_price.text = "\(dict_filter["max_price"] ?? "") \(currency_symbol)"

        lbl_min_price.text = "\(arabic_digits("\(dict_filter["mini_price"] ?? "")")) \(currency_symbol)"
        lbl_max_price.text = "\(arabic_digits("\(dict_filter["max_price"] ?? "")")) \(currency_symbol)"
        
        
        
        
        range_slider.lowerValue = Double(Int(dict_filter["mini_price"]!)!)
        range_slider.upperValue = Double(Int(dict_filter["max_price"]!)!)
        
        set_gradient_on_label(lbl: lbl_product_type)
        set_gradient_on_label(lbl: lbl_sub_product_type)
        set_gradient_on_label(lbl: lbl_size)
        set_gradient_on_label(lbl: lbl_colour)
        set_gradient_on_label(lbl: lbl_sort)
        set_gradient_on_label(lbl: lbl_min_price)
        set_gradient_on_label(lbl: lbl_max_price)
        
        if "\(dict_filter["category_code"] ?? "")" == "0" {
            top_sub_products.constant = 0
            top_color.constant = 0
            top_size.constant = 0
            
            hieght_sub_products.constant = 0
            hieght_color.constant = 0
            hieght_size.constant = 0
            
            view_sub_products.isHidden = true
            view_color.isHidden = true
            view_size.isHidden = true
        } else if "\(dict_filter["subcate_code"] ?? "")" == "0" {
            top_sub_products.constant = 10
            top_color.constant = 0
            top_size.constant = 0
            
            hieght_sub_products.constant = 50
            hieght_color.constant = 0
            hieght_size.constant = 0
            
            view_sub_products.isHidden = false
            view_color.isHidden = true
            view_size.isHidden = true
        } else {
            top_sub_products.constant = 10
            top_color.constant = 10
            top_size.constant = 10
            
            hieght_sub_products.constant = 50
            hieght_color.constant = 50
            hieght_size.constant = 50
            
            view_sub_products.isHidden = false
            view_color.isHidden = false
            view_size.isHidden = false
        }
        
        self.func_check_color_size()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    MARK:- IBActions
    @IBAction func btn_apply(_ sender:Any) {
//        UserDefaults.standard.setValue(dict_filter, forKey: "filter")
        func_filter_prodcut()
    }

    @IBAction func btn_clear_all(_ sender:Any) {
        let alert = UIAlertController (title: "clear".localized, message: "Are you sure ?".localized, preferredStyle: .alert)
        let yes = UIAlertAction(title: "yes".localized, style: .default) { (yes) in
            dict_filter = [
                "category_code":"0",
                "subcate_code":"0",
                "category_name":"All",
                "subcate_name":"All",
                "size":"All",
                "color":"All",
                "mini_price":"10",
                "max_price":"5000",
                "sort_type":"All"
            ]
            
//            UserDefaults.standard.setValue(self.dict_filter, forKey: "filter")
            self.func_set_filter_value()
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name (rawValue: "clear_filter"), object: nil)
        }
        
        let no = UIAlertAction(title: "no".localized, style: .default) { (yes) in
            
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        
        alert.view.tintColor = UIColor .black
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_done_picker(_ sender:UIButton) {
        if index == -1 {
            if picker_view.tag == 1 {
                lbl_product_type.text = Model_filter.shared.arr_category_subcate[0].category_name
                dict_filter["category_name"] = lbl_product_type.text
                dict_filter["category_code"] = Model_filter.shared.arr_category_subcate[0].category_code
                Model_filter.shared.Subcategory = Model_filter.shared.arr_category_subcate[0].Subcategory
            } else if picker_view.tag == 2 {
                if Model_filter.shared.Subcategory.count > 0 {
                    lbl_sub_product_type.text = Model_filter.shared.Subcategory[0].subcategory_name
                    dict_filter["subcate_name"] = lbl_sub_product_type.text
                    dict_filter["subcate_code"] = Model_filter.shared.Subcategory[0].subcategory_code
                    Model_filter.shared.size_guide_id = Model_filter.shared.Subcategory[0].size_guide_id
                    
                    func_get_subcategory_size()
                }
            }  else if picker_view.tag == 3 {
                lbl_size.text = Model_filter.shared.arr_sizes[0]
                dict_filter["size"] = lbl_size.text
            } else if picker_view.tag == 4 {
                lbl_colour.text =  Model_filter.shared.arr_color[0].color_name
                dict_filter["color"] = lbl_colour.text
            } else if picker_view.tag == 5 {
                lbl_sort.text = arr_picker[0]
                dict_filter["sort_type"] = arr_picker[0]
            }
            
//            UserDefaults.standard.setValue(dict_filter, forKey: "filter")
            func_set_filter_value()
        }
        
        index = -1
        
        view_picker_container.isHidden = true
    }
    
    @IBAction func btn_product_type(_ sender:UIButton) {
//        arr_picker = ["Clothes","Shoes","Belts","Sunglasses"]
        func_open_picker(filter_type: 1)
    }
    
    @IBAction func btn_sub_product_type(_ sender:UIButton) {
//        arr_picker = ["T-Shirt","Skirt","Dress","Pants"]
        func_open_picker(filter_type: 2)
    }
    
    @IBAction func btn_size(_ sender:UIButton) {
        arr_picker = ["S","M","L","XL"]
        func_open_picker(filter_type: 3)
    }
    
    @IBAction func btn_colour(_ sender:UIButton) {
        arr_picker = ["Black","White","Red","Blue"]
        func_open_picker(filter_type: 4)
    }
    
    @IBAction func btn_sort(_ sender:UIButton) {
        arr_picker = ["New","Popular","Price: high to low","Price: low to high"]
        func_open_picker(filter_type: 5)
    }
    
    @IBAction func range_hours(_ sender: RangeSlider) {
        lbl_min_price.text = "\(arabic_digits("\(Int(sender.lowerValue))")) \(currency_symbol)"
        lbl_max_price.text = "\(arabic_digits("\(Int(sender.upperValue))")) \(currency_symbol) "
        
        dict_filter["mini_price"] = "\(Int(sender.lowerValue))"
        dict_filter["max_price"] = "\(Int(sender.upperValue))"
    }
    
    func func_open_picker(filter_type:Int) {
        picker_view.tag = filter_type
        picker_view.reloadAllComponents()
        view_picker_container.isHidden = false
    }
    
    func func_get_subcategory_size() {
        func_ShowHud()
        Model_filter.shared.func_get_subcategory_size { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
               self.func_check_color_size()
            }
        }
    }
    
    func func_check_color_size() {
        if Model_filter.shared.arr_color.count == 0 {
            self.top_color.constant = 0
            self.hieght_color.constant = 0
            self.view_color.isHidden = true
        } else {
            self.top_color.constant = 20
            self.hieght_color.constant = 50
            self.view_color.isHidden = false
        }
        
        if Model_filter.shared.arr_sizes.count == 0 {
            self.top_size.constant = 0
            self.hieght_size.constant = 0
            self.view_size.isHidden = true
        } else {
            self.top_size.constant = 20
            self.hieght_size.constant = 50
            self.view_size.isHidden = false
        }
    }

    
}



extension Filter_ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if picker_view.tag == 1 {
            return Model_filter.shared.arr_category_subcate.count
        } else if picker_view.tag == 2 {
            return Model_filter.shared.Subcategory.count
        } else if picker_view.tag == 3 {
            return Model_filter.shared.arr_sizes.count
        } else if picker_view.tag == 4 {
            return Model_filter.shared.arr_color.count
        } else {
            return arr_picker.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if picker_view.tag == 1 {
            return Model_filter.shared.arr_category_subcate[row].category_name
        } else if picker_view.tag == 2 {
            return Model_filter.shared.Subcategory[row].subcategory_name
        } else if picker_view.tag == 3 {
            return Model_filter.shared.arr_sizes[row]
        } else if picker_view.tag == 4 {
            return Model_filter.shared.arr_color[row].color_name
        } else {
            return arr_picker[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if picker_view.tag == 1 {
            lbl_product_type.text = Model_filter.shared.arr_category_subcate[row].category_name
            dict_filter["category_name"] = lbl_product_type.text
            dict_filter["category_code"] = Model_filter.shared.arr_category_subcate[row].category_code
            Model_filter.shared.Subcategory = Model_filter.shared.arr_category_subcate[row].Subcategory
        } else if picker_view.tag == 2 {
            if Model_filter.shared.Subcategory.count > 0 {
                lbl_sub_product_type.text = Model_filter.shared.Subcategory[row].subcategory_name
                dict_filter["subcate_name"] = lbl_sub_product_type.text
                dict_filter["subcate_code"] = Model_filter.shared.Subcategory[row].subcategory_code
                Model_filter.shared.size_guide_id = Model_filter.shared.Subcategory[row].size_guide_id
                
                func_get_subcategory_size()
            }
        }  else if picker_view.tag == 3 {
            lbl_size.text = Model_filter.shared.arr_sizes[row]
            dict_filter["size"] = lbl_size.text
        } else if picker_view.tag == 4 {
            lbl_colour.text =  Model_filter.shared.arr_color[row].color_name
            dict_filter["color"] = lbl_colour.text
        } else if picker_view.tag == 5 {
            lbl_sort.text = arr_picker[row]
            dict_filter["sort_type"] = arr_picker[row]
        }
        
//        UserDefaults.standard.setValue(dict_filter, forKey: "filter")
        index = row
        func_set_filter_value()
    }
    
}



// MARK:- API METHODS CALLING
extension Filter_ViewController {
    func func_category_subcate()  {
        func_ShowHud()
        Model_filter.shared.func_category_subcate { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
            }
        }
    }
    
    func func_filter_prodcut() {
        func_ShowHud()
        Model_filter.shared.func_filter_prodcut { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name (rawValue: "filter"), object: nil)
            }
        }
    }

    
    
}




