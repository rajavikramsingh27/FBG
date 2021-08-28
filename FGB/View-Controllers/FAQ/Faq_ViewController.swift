//  Faq_ViewController.swift
//  FGB

//  Created by appentus on 6/21/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit

class Faq_ViewController: UIViewController {
    @IBOutlet weak var nav_bar:UINavigationBar!
    @IBOutlet weak var tbl_faq:UITableView!
    
    var arr_select = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_bar.applyNavGradient()
        
        func_get_faq()
    }
    
    func func_get_faq() {
        func_ShowHud()
        Model_FAQ.shared.func_get_faq { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                self.arr_select = [Bool]()
                
                for _ in Model_FAQ.shared.arr_get_faq {
                    self.arr_select.append(false)
                }
                
                self.tbl_faq.reloadData()
            }
        }
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
}



extension Faq_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arr_select[indexPath.row] {
            let textString = Model_FAQ.shared.arr_get_faq[indexPath.row].faq_ans as NSString
            return func_height_text(textString: textString)+90
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_FAQ.shared.arr_get_faq.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FAQ_TableViewCell
        
        let model = Model_FAQ.shared.arr_get_faq[indexPath.row]
        cell.lbl_faq_title.text = model.faq_title
        
        cell.btn_select.tag = indexPath.row
        cell.btn_select.addTarget(self, action: #selector(btn_select(_:)), for: .touchUpInside)
        
        if arr_select[indexPath.row] {
            cell.btn_up_down.isSelected = true
            cell.lbl_faq_ans.text = model.faq_ans
            
            let textString = Model_FAQ.shared.arr_get_faq[indexPath.row].faq_ans as NSString
            cell.height_faq_ans.constant = func_height_text(textString: textString)
        } else {
            cell.btn_up_down.isSelected = false
            cell.lbl_faq_ans.text = ""
            cell.height_faq_ans.constant = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func btn_select(_ sender:UIButton) {
        for i in 0..<Model_FAQ.shared.arr_get_faq.count {
            if i == sender.tag {
                if arr_select[i] {
                    arr_select[i] = false
                } else {
                    arr_select[i] = true
                }
            } else {
                arr_select[i] = false
            }
        }
        tbl_faq.reloadData()
    }
    
    func func_height_text(textString:NSString) -> CGFloat {
        let font = UIFont .systemFont(ofSize: 18)
        let textAttributes = [NSAttributedStringKey.font: font]
        
        let textRect = textString.boundingRect(with: CGSize (width: self.view.frame.size.width-40, height: 2000), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        return textRect.size.height
    }
    
}
