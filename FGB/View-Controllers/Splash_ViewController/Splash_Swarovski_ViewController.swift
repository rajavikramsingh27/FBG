//  Splash_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 12/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import MediaPlayer
import AVKit



class Splash_Swarovski_ViewController: UIViewController {
    @IBOutlet weak var img_Swarovski:UIImageView!
    @IBOutlet weak var view_full_video:UIView!
    @IBOutlet weak var btn_skip:UIButton!
    @IBOutlet weak var video_view_bottom: NSLayoutConstraint!
    
    var timer_user_active = Timer()
    var timer_count = 0
    var player = AVPlayer()
    
    var once = false
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var select_country_VC = Select_Country_ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modelName = UIDevice.modelName
        if modelName == "iPhone X" || modelName == "iPhone XS" || modelName == "iPhone XS Max" || modelName == "iPhone XR" || modelName == "Simulator iPhone XR"{
           video_view_bottom.constant = -275.0
        }else{
            video_view_bottom.constant = 0.0
        }
        
        btn_skip.setTitle("skip".localized, for: .normal)
        
        btn_skip.isHidden = true
        self.playVideo()
//        self.playVideo_1()
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_select_Country), name: NSNotification.Name (rawValue: "select_Country"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timer_user_active = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(func_timer), userInfo: nil, repeats: true)
    }
    
    func func_auto_login() {
        if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
            let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
            print(dict_LoginData)
            
            Model_Walk_Through.shared.customer_id = "\(dict_LoginData["customer_id"] ?? "")"
            Model_Walk_Through.shared.customer_social_id = "\(dict_LoginData["customer_social_id"] ?? "")"
            Model_Walk_Through.shared.customer_password = "\(dict_LoginData["customer_password"] ?? "")"
            
            currency_symbol = "\(dict_LoginData["currency_symbol"] ?? "")"
            currency_price = "\(dict_LoginData["currency_price"] ?? "")"
            currency_idd = "\(dict_LoginData["currency_id"] ?? "")"
            
            if k_FireBaseFCMToken.isEmpty {
                Model_Login.shared.device_token = dict_LoginData["customer_device_token"] as! String
            }
            
            if let password = UserDefaults.standard.object(forKey: "password") as? String {
                Model_Login.shared.password = password
            }
            
            player.pause()
            timer_count = 0
            timer_user_active .invalidate()
            
            self.select_country_VC = self.storyboard?.instantiateViewController(withIdentifier: "Select_Country_ViewController") as! Select_Country_ViewController
            self.view.addSubview(self.select_country_VC.view)
            self.addChildViewController(self.select_country_VC)
        } else {
            func_present_walkthrough()
        }
        
    }
    
    @objc func func_select_Country() {
        func_update_setting()
    }
    
    func func_update_setting() {
        func_ShowHud()
        Model_setting.shared.func_update_setting { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    self.func_is_user_active()
                } else {
                    self.func_ShowHud_Error(with: Model_setting.shared.str_message)
                }
            }
        }
    }
    
    @objc func func_is_user_active() {
        func_ShowHud()
        Model_Tabbar.shared.func_is_user_active { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
//                    self.select_country_VC.view.removeFromSuperview()
                let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar_Controller
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabbar
                appDelegate.window?.makeKeyAndVisible()
//                let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
//                self.present(tabbar!, animated: true, completion: nil)
            }
        }
    }
    
    @objc func func_timer() {
        timer_count = timer_count+1
        
        btn_skip.isHidden = false
        if timer_count < 5 {
            btn_skip.isHidden = true
            
        }
        
        if timer_count == 13 {
            func_auto_login()
//            func_present_walkthrough()
        }
    }
    
    @IBAction func btn_skip(_ sender:UIButton) {
        player.pause()
        func_auto_login()
    }
    
    func func_present_walkthrough() {
        timer_count = 0
        timer_user_active .invalidate()
//        let dimong = self.storyboard?.instantiateViewController(withIdentifier: "Walk_Through_ViewController") as! Walk_Through_ViewController
//        self.present(dimong, animated: true, completion: nil)
//        func func_present_items_VC() {
            let search_VC = storyboard?.instantiateViewController(withIdentifier: "Login_ViewController")
            self.present(search_VC!, animated: true, completion: nil)
//        }
    }
    
    private func playVideo() {
        
        guard let path = Bundle.main.path(forResource: "fgb-splash", ofType:".mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        playerLayer.videoGravity = .resize
        view_full_video.layer.addSublayer(playerLayer)
        player.play()
        player.volume = 1.0
    }
    
    @IBAction func btn_mute(_ sender:UIButton) {
        if player.isMuted {
            player.isMuted = false
            sender.isSelected = false
        } else {
            player.isMuted = true
            sender.isSelected = true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
