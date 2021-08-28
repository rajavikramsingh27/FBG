//  Payment_Methods_List_Next_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class Payment_Methods_List_Next_ViewController: UIViewController {
    @IBOutlet weak var tbl_card_list:UITableView!
    
    let arr_card_value = ["**** **** **** 9876","sales@appentus.com"]
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func func_view_card() {
        func_ShowHud()
        Model_payment_methods.shared.func_view_card { (status) in
            DispatchQueue.main.async {
                self.tbl_card_list.reloadData()
                self.func_HideHud()
            }
        }
    }
    
    func func_remove_card() {
        func_ShowHud()
        Model_payment_methods.shared.func_remove_card { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_payment_methods.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_payment_methods.shared.str_message)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.func_HideHud()
                    self.func_view_card()
                }
            }
        }
    }
    
    

}




extension Payment_Methods_List_Next_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_payment_methods.shared.arr_view_card.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Payment_methods_list_Next_TableViewCell
        
        let model = Model_payment_methods.shared.arr_view_card[indexPath.row]
        
        if model.card_type == "Paypal" {
            cell.lbl_card_value.text = model.payment_email
        } else {
            cell.lbl_card_value.text = "****-****-****-\(model.card_number.suffix(5))"
        }
        
        cell.btn_delete.tag = indexPath.row
        cell.btn_edit.tag = indexPath.row
        
        cell.btn_delete.addTarget(self, action: #selector(btn_delete(_:)), for: .touchUpInside)
        cell.btn_edit.addTarget(self, action: #selector(btn_edit(_:)), for: .touchUpInside)
        set_gradient_on_label(lbl: cell.lbl_card_value)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func btn_delete(_ sender:UIButton) {
        Model_payment_methods.shared.card_id = Model_payment_methods.shared.arr_view_card[sender.tag].card_id
        let alert = UIAlertController (title: "Warning!", message: "Are you sure ?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { (yes) in
            self.func_remove_card()
        }
        
        let no = UIAlertAction(title: "No", style: .default) { (yes) in
            
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        
        alert.view.tintColor = UIColor .black
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_edit(_ sender:UIButton) {
        let model = Model_payment_methods.shared.arr_view_card[sender.tag]
        
        if model.card_type == "Paypal" {
            Model_paypal_login.shared.is_edit = true 
            Model_paypal_login.shared.card_details = model
            let payment_list = storyboard?.instantiateViewController(withIdentifier: "Paypal_Login_ViewController") as! Paypal_Login_ViewController
            present(payment_list, animated: true, completion: nil)
        } else {
            Model_credit_card.shared.is_edit = true
            Model_credit_card.shared.card_details = model
            
            let payment_list = storyboard?.instantiateViewController(withIdentifier: "Credit_Debit_Card_ViewController") as! Credit_Debit_Card_ViewController
            present(payment_list, animated: true, completion: nil)
        }
    }

}



