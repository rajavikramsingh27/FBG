//
//  Size_Guide_ViewController.swift
//  FGB
//
//  Created by appentus on 6/20/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Size_Guide_ViewController: UIViewController {
    @IBOutlet weak var btn_done:UIButton!
    @IBOutlet weak var tbl_size:UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set_grad_to_btn(btn: btn_done)
        func_get_products()
        btn_done.setTitle("done".localized, for: .normal)
    }
    
    func func_get_products() {
        func_ShowHud()
        Model_Size_Guize.shared.func_size_guide_data { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                self.tbl_size.reloadData()
            }
        }
    }
    
    @IBAction func btn_done(_ sender:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "size_guide"), object: nil)
    }
    
}



extension Size_Guide_ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Size_Guize.shared.arr_size_guide_usa.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Size_Guide_TableViewCell
        
        cell.lbl_uk.text = Model_Size_Guize.shared.arr_size_guide_uk[indexPath.row]
        cell.lbl_eu.text = Model_Size_Guize.shared.arr_size_guide_eu[indexPath.row]
        cell.lbl_us.text = Model_Size_Guize.shared.arr_size_guide_usa[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
