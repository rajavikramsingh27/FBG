//  Wallet_ViewController.swift
//  FGB

//  Created by appentus on 6/28/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

var str_total_points = ""

class Wallet_ViewController: UIViewController {
    @IBOutlet weak var tbl_wallet:UITableView!
    
    @IBOutlet weak var lbl_my_wallet:UILabel!
    @IBOutlet weak var lbl_total_points:UILabel!
    @IBOutlet weak var lbl_all_transactions:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func_wallet_use()
        
        let points = "points".localized
        lbl_total_points.text = "\(str_total_points) \(points)"
        lbl_all_transactions.text = "transaction".localized
        lbl_my_wallet.text = "mywallet".localized
        
        set_gradient_on_label(lbl: lbl_my_wallet)
        set_gradient_on_label(lbl: lbl_total_points)
        set_gradient_on_label(lbl: lbl_all_transactions)
    }
    
    @IBAction func btn_back(_ sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func func_wallet_use() {
        func_ShowHud()
        Model_Wallet.shared.func_wallet_use { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                self.tbl_wallet.reloadData()
            }
        }
    }

}



extension Wallet_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Wallet.shared.arr_wallet_use.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Wallet_TableViewCell
        
        let model = Model_Wallet.shared.arr_wallet_use[indexPath.row]
        
        cell.img_product.sd_setShowActivityIndicatorView(true)
        cell.img_product.sd_setIndicatorStyle(.gray)
        cell.img_product.sd_setImage(with:URL (string:model.image_path), placeholderImage:(UIImage(named:"Mask Group -11.png")))
        
        let product = "product".localized
        let order_id = "orderId".localized
        let qty = "qty".localized
        let price = "price".localized
        
        cell.lbl_product_name.text = "\(product): "+model.product_name
        cell.lbl_order_id.text = "\(order_id): "+model.order_items_id
        cell.lbl_quantity.text = "\(qty) "+model.order_product_qty
//        let full_price = func_total_amt_pay(model: model)
//        print("full_price is:-",full_price)
        
        let wallet_discount = Double(model.wallet_discount)!
        let currency_price = Double(model.currency_price)!
        
        let full_wallet_price = wallet_discount*currency_price
        
        cell.lbl_price.text = "\(price): \(String(format: "%.2f",full_wallet_price)) \(model.currency_name)"
        cell.lbl_date.text = model.order_date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func func_total_amt_pay(model:Model_Wallet) -> String {
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
            return String(format: "%.2f", total_price+tax_calculation-wallet_discount)
        } else {
            let arr_delivery_type_cost = model.delivery_type_cost.components(separatedBy: " ")
            let full_price = Double(currency_price)!*Double(Int(arr_delivery_type_cost[0])!)
            return String(format: "%.2f", (total_price+tax_calculation+full_price)-wallet_discount)
        }
        
    }
    
}
