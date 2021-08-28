
//
//  File.swift
//  FGB
//
//  Created by iOS-Appentus on 20/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//


import UIKit

class Splash_ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.func_present_walk_through()
//            self.func_auto_login()
        }
    }
    
    func func_present_walk_through() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let login_VC = self.storyboard?.instantiateViewController(withIdentifier: "Splash_Swarovski_ViewController") as! Splash_Swarovski_ViewController
            self.present(login_VC, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func func_login() {
//        func_ShowHud()
        Model_Login.shared.func_login { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_present_tabbar()
                } else {
                    self.func_present_walk_through()
                }
            }
        }
    }
    
    func func_do_social_login() {
//        func_ShowHud()
        Model_Login.shared.func_do_social_login { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if status == "success" {
                    self.func_present_tabbar()
                } else {
                    self.func_present_walk_through()
                }
            }
        }
        
    }
    
    func func_present_tabbar() {
        let sign_VC = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
        self.present(sign_VC!, animated: true, completion: nil)
    }

    
    
}



