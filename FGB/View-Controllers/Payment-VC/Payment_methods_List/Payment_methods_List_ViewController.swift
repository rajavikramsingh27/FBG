//  Payment_methods_List_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 09/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit



class Payment_methods_List_ViewController: UIViewController {
    @IBOutlet weak var btn_credit_card:UIButton!
    @IBOutlet weak var btn_paypal:UIButton!
    @IBOutlet weak var tbl_cards:UITableView!
    @IBOutlet weak var view_add_cards:UIView!
    
    @IBOutlet weak var btn_edit:UIBarButtonItem!
    
    let arr_payment_type = ["Credit / Debit card","Paypal"]
    let arr_card_value = ["**** **** **** 9876","sales@appentus.com"]
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        view_add_cards.isHidden = true
        tbl_cards.isHidden = true
        btn_edit.title = ""
        
        btn_credit_card.layer.cornerRadius = 6
        btn_credit_card.clipsToBounds = true
        
        btn_paypal.layer.cornerRadius = 6
        btn_paypal.clipsToBounds = true
        
        if is_checkout {
            tbl_cards.allowsSelection = true
            tbl_cards.allowsMultipleSelection = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func_view_card()
        
        Model_paypal_login.shared.is_edit = false
        Model_credit_card.shared.is_edit = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_edit(_ sender:Any) {
        let payment_list = storyboard?.instantiateViewController(withIdentifier: "Payment_Methods_List_Next_ViewController") as! Payment_Methods_List_Next_ViewController
        present(payment_list, animated: true, completion: nil)
    }
    
    @IBAction func btn_add_payement_methods(_ sender:Any) {
        is_add_pay_first = false

        let payment_list = storyboard?.instantiateViewController(withIdentifier: "Payment_Methods_ViewController") as! Payment_Methods_ViewController
        present(payment_list, animated: true, completion: nil)
    }
    
    @IBAction func btn_paypal(_ sender:Any) {
        let payment_list = storyboard?.instantiateViewController(withIdentifier: "Paypal_Login_ViewController") as! Paypal_Login_ViewController
        present(payment_list, animated: true, completion: nil)
    }
    
    @IBAction func btn_Credit_card(_ sender:Any) {
        is_add_pay_first = true
        
        let payment_list = storyboard?.instantiateViewController(withIdentifier: "Credit_Debit_Card_ViewController") as! Credit_Debit_Card_ViewController
        present(payment_list, animated: true, completion: nil)
    }
    
    func func_view_card() {
        func_ShowHud()
        Model_payment_methods.shared.func_view_card { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if Model_payment_methods.shared.arr_view_card.count == 0 {
                    self.view_add_cards.isHidden = false
                    self.tbl_cards.isHidden = true
                    self.btn_edit.title = ""
                } else {
                    self.view_add_cards.isHidden = true
                    self.tbl_cards.isHidden = false
                    self.btn_edit.title = "Edit"
                    self.tbl_cards.reloadData()
                }
            }
        }
    }
    
}



extension Payment_methods_List_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_payment_methods.shared.arr_view_card.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Payment_methods_list_TableViewCell
        let model = Model_payment_methods.shared.arr_view_card[indexPath.row]
        
        cell.lbl_payment_type.text = model.card_type
        
        if model.card_type == "Paypal" {
            cell.lbl_card_number.text = model.payment_email
        } else {
            cell.lbl_card_number.text = "****-****-****-\(model.card_number.suffix(5))"
        }
        
        
        cell.lbl_default_peyment.isHidden = true
        set_gradient_on_label(lbl: cell.lbl_card_number)
        set_gradient_on_label(lbl: cell.lbl_payment_type)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if is_checkout {
            let model = Model_payment_methods.shared.arr_view_card[indexPath.row]
            str_payment_type = model.card_type
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}




