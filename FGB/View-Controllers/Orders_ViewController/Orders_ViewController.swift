//  Orders_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 08/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

var is_from_order = false

class Orders_ViewController: UIViewController {
    @IBOutlet weak var btn_start_shopping:UIButton!
    @IBOutlet weak var tbl_orders:UITableView!
    @IBOutlet weak var tbl_orders_return:UITableView!
    @IBOutlet weak var view_return:UIView!
    @IBOutlet weak var view_orders:UIView!
    
    @IBOutlet weak var nav_bar:UINavigationBar!
    
    @IBOutlet weak var no_orders:UILabel!
    
    var arr_selected = [Bool]()
    
    var arr_radio = [Bool]()
    
    var page = 1
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_return.isHidden = true
        nav_bar.topItem?.title = "order".localized
        no_orders.text = "noorder".localized
        btn_start_shopping.setTitle("start_shopping".localized, for:.normal)
        
        btn_start_shopping.layer.cornerRadius = btn_start_shopping.frame.size.height/2
        btn_start_shopping.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view_return.isHidden = true
        func_reason_list()
        self.arr_selected.removeAll()
        Model_Order.shared.arr_order_list.removeAll()
        Model_Order.shared.page = "1"
        func_order_list()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_start_shopping(_ sender:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "start_shopping"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func func_order_list() {
        func_ShowHud()
        Model_Order.shared.func_order_list { (status) in
            DispatchQueue.main.async {
                if Model_Order.shared.arr_order_list.count == 0 {
                    self.view_orders.isHidden = true
                } else {
                    self.view_orders.isHidden = false
                }
                
                if status == "success" {
                    for _ in 0..<Model_Order.shared.arr_order_list.count {
                        self.arr_selected.append(false)
                    }
                } else {
                    self.page = self.page-1
                }
                
//                self.arr_selected.removeAll()
                self.tbl_orders.reloadData()
                self.func_HideHud()
            }
        }
    }
    
    func func_reason_list() {
        func_ShowHud()
        Model_Order.shared.func_reason_list { (status) in
            DispatchQueue.main.async {
                
                self.arr_radio.removeAll()
                for _ in 0..<Model_Order.shared.arr_reason_list.count {
                    self.arr_radio.append(false)
                }
                
                if status == "success" {
//                    self.view_return.isHidden = false
                }
                
                self.tbl_orders_return.reloadData()
                self.func_HideHud()
            }
        }
    }
    
    
    func func_cancel_order_item() {
        func_ShowHud()
        Model_Order.shared.func_cancel_order_item { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    
                    for i in 0..<self.arr_selected.count {
                        self.arr_selected[i] = false
                    }
                    self.func_ShowHud_Success(with: Model_Order.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Order.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.func_HideHud()
                    if status == "success" {
                        Model_Order.shared.arr_order_list.removeAll()
                        Model_Order.shared.page = "1"
                        self.func_order_list()
                    }
                })
            }
        }
    }
    
    func func_product_return() {
        func_ShowHud()
        Model_Order.shared.func_product_return { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                self.view_return.isHidden = true
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Order.shared.str_message)
                    self.view_return.isHidden = true
                } else {
                    self.func_ShowHud_Error(with: Model_Order.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0, execute: {
                    self.func_HideHud()
                    
                })
                self.func_reason_list()
                self.arr_selected.removeAll()
                Model_Order.shared.arr_order_list.removeAll()
                Model_Order.shared.page = "1"
                self.func_order_list()

                
            }
        }
    }
    
}



extension Orders_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tbl_orders {
            return 150
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbl_orders {
            return Model_Order.shared.arr_order_list.count
        } else {
            return arr_radio.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl_orders {
            if Model_Order.shared.arr_order_list.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Orders_TableViewCell
                
                return cell
            } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Orders_TableViewCell
            
            let model = Model_Order.shared.arr_order_list[indexPath.row]
                
            cell.lbl_order_id.text = "#\(model.order_items_id)"
            cell.lbl_product_name.text = "\(model.product_name)"
            cell.lbl_time.text = "\(model.order_date)"
//            let full_price = Double(currency_price)!*Double(Int(model.order_product_total)!)
            let full_price = func_total_amt_pay(model: model)
            
            let total = "total".localized
                
            cell.lbl_total_amt.text = "\(total) : \(arabic_digits("\(full_price)")) \(model.currency_name)"
            
            var diff_days = 0
            var str_time_ago = ""
            
            var str_cancel_title = ""
                cell.btn_cancel_white.setTitle("cancel".localized, for: .normal)

            if model.order_product_status == "0" {
                cell.lbl_processing.backgroundColor = hexStringToUIColor(hex: "1E67FF")
                cell.lbl_processing.text = "orderplaced".localized
                cell.btn_more.isHidden = false
                str_cancel_title = "Cancel"
            } else if model.order_product_status == "1" {
                cell.lbl_processing.backgroundColor = UIColor .lightGray
                cell.lbl_processing.text = "processing".localized
                cell.btn_more.isHidden = false
                str_cancel_title = "Cancel"
            } else if model.order_product_status == "2" {
                if model.refund_policy == "1"{
                    cell.lbl_processing.backgroundColor = UIColor .lightGray
                    cell.lbl_processing.text = "completed".localized
                    cell.btn_more.isHidden = false
                    cell.btn_cancel_white.setTitle("textreturn".localized, for: .normal)
//                    cell.btn_more_1.setTitle("Return", for: .normal)
                    str_cancel_title = "Return"
                }else{
                    cell.lbl_processing.backgroundColor = UIColor .lightGray
                    cell.lbl_processing.text = "completed".localized
                    cell.btn_more.isHidden = true
                    str_cancel_title = "Return"
                }
                
            } else {
                cell.lbl_processing.backgroundColor = hexStringToUIColor(hex: "FD372F")
                cell.lbl_processing.text = "cenceled".localized
                cell.btn_more.isHidden = true
            }
            
//            cell.btn_cancel_white.setTitle(str_cancel_title, for: .normal)
                
            if arr_selected[indexPath.row] {
                cell.width_cancel_white.constant = 110
                cell.btn_more_1.isHidden = false
            } else {
                cell.width_cancel_white.constant = 0
                cell.btn_more_1.isHidden = true
            }
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
                cell.contentView.layoutIfNeeded()
            })
            
            cell.btn_cancel_white.tag = indexPath.row
            cell.btn_cancel_white.addTarget(self, action: #selector(btn_cancel_order(_:)), for: .touchUpInside)
            
            cell.btn_more.tag = indexPath.row
            cell.btn_more_1.tag = indexPath.row
            cell.btn_more.addTarget(self, action: #selector(btn_more(_:)), for: .touchUpInside)
            cell.btn_more_1.addTarget(self, action: #selector(btn_more(_:)), for: .touchUpInside)
            
            set_gradient_on_label(lbl: cell.lbl_order_id)
            set_gradient_on_label(lbl: cell.lbl_time)
            set_gradient_on_label(lbl: cell.lbl_total_amt)
            
            return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Order_Return_ViewController
            
            cell.lbl_alert.text = Model_Order.shared.arr_reason_list[indexPath.row].reason_name
            
            if arr_radio[indexPath.row] {
                cell.btn_radio.isSelected = true
            } else {
                cell.btn_radio.isSelected = false
            }
            
            cell.btn_radio.tag = indexPath.row
            cell.btn_radio.addTarget(self, action: #selector(btn_radio(_:)), for: .touchUpInside)
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        is_from_order = true
        
        Model_payment_checkout.shared.model_order = Model_Order.shared.arr_order_list[indexPath.row]
        
        if tableView == tbl_orders {
            let orders = storyboard?.instantiateViewController(withIdentifier: "Order_Details_ViewController") as! Order_Details_ViewController
            present(orders, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        if ((tbl_orders.contentOffset.y + tbl_orders.frame.size.height) >= scrollView.contentSize.height) {
            page = page+1
            Model_Order.shared.page = "\(page)"
            func_order_list()
        }
    }
    
    @IBAction func btn_hide_view_return(_ sender:UIButton) {
        view_return.isHidden = true
    }
    
    @IBAction func btn_cancel_order(_ sender:UIButton) {
        if sender.title(for: .normal) == "textreturn".localized {
            let alert = UIAlertController (title: "textreturn".localized, message: "Are you sure?".localized, preferredStyle: .alert)
            let yes = UIAlertAction(title: "yes".localized, style: .default) { (yes) in
                let model = Model_Order.shared.arr_order_list[sender.tag]
                Model_Order.shared.order_items_id = model.order_items_id
                Model_Order.shared.product_id = model.product_id
                
                self.return_product()
            }
            
            let no = UIAlertAction(title: "no".localized, style: .default) { (yes) in
                
            }
            
            alert.addAction(yes)
            alert.addAction(no)
            
            alert.view.tintColor = UIColor .black
            present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController (title: "cencelorder".localized, message: "cancelorder".localized, preferredStyle: .alert)
            let yes = UIAlertAction(title: "yes".localized, style: .default) { (yes) in
                let model = Model_Order.shared.arr_order_list[sender.tag]
                Model_Order.shared.order_items_id = model.order_items_id
                Model_Order.shared.product_id = model.product_id
                
                self.func_cancel_order_item()
            }
            
            let no = UIAlertAction(title: "no".localized, style: .default) { (yes) in
                
            }
            
            alert.addAction(yes)
            alert.addAction(no)
            
            alert.view.tintColor = UIColor .black
            present(alert, animated: true, completion: nil)
        }
       
    }
    
    
    
    
    
    
    func return_product() {
        self.view_return.isHidden = false
    }
    
    @IBAction func btn_more(_ sender:UIButton) {
        
        for i in 0..<Model_Order.shared.arr_order_list.count {
            if i == sender.tag {
                if arr_selected[i] {
                    arr_selected[i] = false
                } else {
                     arr_selected[i] = true
                }
            } else {
                arr_selected[i] = false
            }
        }
        tbl_orders.reloadData()
    }
    
    @IBAction func btn_radio(_ sender:UIButton) {
        for i in 0..<Model_Order.shared.arr_reason_list.count {
            if i == sender.tag {
                arr_radio[i] = true
            } else {
                arr_radio[i] = false
            }
        }
        
        Model_Order.shared.reason_name = Model_Order.shared.arr_reason_list[sender.tag].reason_name
        tbl_orders_return.reloadData()
    }
    
    @IBAction func btn_return(_ sender:UIButton) {
        func_product_return()
    }
    
    func func_total_amt_pay(model:Model_Order) -> String {
        let double_currency_price = Double(model.currency_price)
        let double_product_price = Double(model.product_price)
        let double_order_product_qty = Double(model.order_product_qty)
        
        let total_price = double_currency_price!*double_product_price!*double_order_product_qty!
        
        let taxt_percent = model.tax_rate
        let tax_calculation = (total_price*Double(Int(taxt_percent)!))/100
        
        var wallet_discount = 0.0
        if (model.wallet_discount.isEmpty || model.wallet_discount == "0") && (model.promo_discount.isEmpty || model.promo_discount == "0") {
            wallet_discount = 0.0
        } else {
            if model.wallet_discount != "0" {
                wallet_discount = Double(model.currency_price)!*Double(model.wallet_discount)!
            }
            if model.promo_discount != "0" {
                wallet_discount = Double(model.currency_price)!*Double(model.promo_discount)!
            }
        }
        
        if model.delivery_type == "Standard Delivery" {
            return String(format: "%.2f", total_price+tax_calculation-wallet_discount).replacingOccurrences(of: "-", with: "")
        } else {
            let arr_delivery_type_cost = model.delivery_type_cost.components(separatedBy: " ")
            let full_price = Double(currency_price)!*Double(Int(arr_delivery_type_cost[0])!)
            return String(format: "%.2f", (total_price+tax_calculation+full_price)-wallet_discount).replacingOccurrences(of: "-", with: "")
        }
        
    }
    
    
}


