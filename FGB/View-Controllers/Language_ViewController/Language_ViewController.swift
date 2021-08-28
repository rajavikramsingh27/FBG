//
//  adsfViewController.swift
//  FGB
//
//  Created by appentus on 7/1/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit


class Language_ViewController: UIViewController {
    
    @IBOutlet weak var progressBar : UIProgressView!
    @IBOutlet weak var lbl_wearetran : UILabel!
    
    var timer: Timer?
    var array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Language.language)
        lbl_wearetran.text = "We are Translating..."
        
        doStuff()
    }
    
    func doStuff() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            DispatchQueue.main.async {
            
            self.array.append("foo")
            
            let change: Float = 0.1
            self.progressBar.progress = self.progressBar.progress + (change)
            
            var language = "en"
            if let default_value = UserDefaults.standard.object(forKey: "Language") as? String {
                if default_value == "English" {
                    language = "en"
                    Language.language = Language.english
                } else {
                    language = "ar"
                    Language.language = Language.arabic
                }
            }
            
            let lang_ccurrent = Language.language
            
//            if lang_ccurrent == "en"{
//                UserDefaults.standard.set("English", forKey: "Language")
//            }else{
//                UserDefaults.standard.set("عربى", forKey: "Language")
//            }
                
                
                
                
                if self.progressBar.progress >= 1.0 {
//                    self.presentingViewController!.dismiss(animated: true, completion: nil)
                    self.timer?.invalidate()
                    
//                    let appdelegate = AppDelegate()
//                    appdelegate.applicationDidFinishLaunching?(UIApplication.shared)
                    let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar_Controller
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = tabbar
                    appDelegate.window?.makeKeyAndVisible()
                    
                }
            }
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
}
