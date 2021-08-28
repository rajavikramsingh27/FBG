//  ViewControllerasdfsdfas.swift
//  FGB
//  Created by iOS-Appentus on 19/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import Foundation
import SVProgressHUD
import UserNotifications



class TabBar_Controller: UITabBarController ,UITabBarControllerDelegate {
    var timer_user_active = Timer()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func_add_whatsApp()
        
        let numberOfItems = CGFloat(tabBar.items!.count)
        var tabBarItemSize = CGSize()
        
        if UIScreen.main.nativeBounds.height == 1792 {
            tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height+35)
        } else if UIScreen.main.nativeBounds.height > 2208 {
            tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height+35)
        } else {
             tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height-23)
        }
        
        self.tabBar.unselectedItemTintColor = hexStringToUIColor(hex: "CFC25D")
        
//        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color:color_gold, size: tabBarItemSize).resizableImage(withCapInsets: UIEdgeInsets.zero)
        
        // remove default border
        tabBar.frame.size.width = self.view.frame.width
        tabBar.frame.origin.x = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_start_shopping), name: NSNotification.Name (rawValue: "start_shopping"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_Go_to_Bag), name: NSNotification.Name (rawValue: "Go_to_Bag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(func_view_cart), name: NSNotification.Name (rawValue: "Bag_count"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(func_sign_out), name: NSNotification.Name (rawValue: "sign_out"), object: nil)
        
        timer_user_active = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(func_is_user_active), userInfo: nil, repeats: true)
        
        func_view_cart()
        
        self.tabBar.items![0].title = "shop".localized
        self.tabBar.items![1].title = "category".localized
        self.tabBar.items![2].title = "bag".localized
        self.tabBar.items![3].title = "wishlist".localized
        self.tabBar.items![4].title = "profile".localized
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if  #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        } else {
            UIApplication.shared.cancelAllLocalNotifications()
        }
        let width_tabbar_item = tabBar.frame.size.width / 5
        
        let modelName = UIDevice.modelName
        var height = CGFloat()
//        if modelName == "iPhone X" || modelName == "iPhone XS" || modelName == "iPhone XS Max" || modelName == "iPhone XR"{
            height = 48.0
//        }else{
//            height = 24.0
//        }
        let size_img = CGSize(width: width_tabbar_item, height: height)
        let image = UIImage.imageWithColor(color:UIColor .red, size: size_img).resizableImage(withCapInsets: UIEdgeInsets.zero)
        let resized_image = resizeImage(image: image, targetSize: CGSize(width: width_tabbar_item, height: height))
        tabBar.selectionIndicatorImage = resized_image
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func func_start_shopping() {
        self.selectedIndex = 0
    }
    
    @objc func func_Go_to_Bag() {
        self.selectedIndex = 2
    }
    
    @objc func func_sign_out() {
        timer_user_active.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            UserDefaults.standard.removeObject(forKey: "login_Data")
        }
        
    }
    
    @objc func func_view_cart() {
        Model_Tabbar.shared.func_view_cart { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if Model_Tabbar.shared.arr_view_cart.count == 0 {
                    self.tabBar.items?[2].badgeValue = nil
                } else {
                    self.tabBar.items?[2].badgeValue = "\(Model_Tabbar.shared.arr_view_cart.count)"
                }
            }
        }
    }
    
    @objc func func_is_user_active() {
        Model_Tabbar.shared.func_is_user_active { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
//                if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
//                    let dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
////                    print(dict_LoginData)
//
//                    if Model_Tabbar.shared.customer_device_token != k_FireBaseFCMToken {
//                        SVProgressHUD.showError(withStatus: "This account has logged in another device")
//                        self.timer_user_active.invalidate()
//                        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
//                            self.func_action_logout()
//                            self.func_HideHud()
//
//                            return
//                        })
//                    }
//
//                } else {
//                    self.timer_user_active.invalidate()
//                    return
//                }
                
                if Model_Tabbar.shared.cart_item == "0" {
                    self.tabBar.items?[2].badgeValue = nil
                } else {
                    self.tabBar.items?[2].badgeValue = "\(Model_Tabbar.shared.cart_item)"
                }
                
                if Model_Tabbar.shared.customer_password != Model_Walk_Through.shared.customer_password {
                    SVProgressHUD.showError(withStatus: "This account password has been change")
                    self.timer_user_active.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                        self.func_action_logout()
                        self.func_HideHud()
                    })
                } else if Model_Tabbar.shared.message == "inactive" {
                        if Reachability.isConnectedToNetwork() {
                            self.func_ShowHud_Error(with: "This account has been delete")
                            self.timer_user_active.invalidate()
                            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                                self.func_action_logout()
                                self.func_HideHud()
                            })
                        }
//                    }
                    
                }
            }
        }
    }
    
    func func_action_logout() {
            UserDefaults.standard.removeObject(forKey: "login_Data")
            
            let login_VC = self.storyboard?.instantiateViewController(withIdentifier: "Login_ViewController")
            self.present(login_VC!, animated: true, completion: nil)
    }
    
    func func_add_whatsApp() {
        let view_camera = Bundle.main.loadNibNamed("WhatsApp", owner: self, options: nil)?.first as! WhatsApp
        
//        view_camera.layer.cornerRadius = view_camera.frame.size.height/2
//        view_camera.clipsToBounds = true
        
        let origin = self.view.frame.origin
        let size = self.view.frame.size
        
        let camera_height_width = CGFloat(60)
        var tabbar_height = CGFloat()
        if self.view.frame.size.height > 736 {
            tabbar_height = CGFloat(50)
            view_camera.frame = CGRect(x: origin.x+size.width-camera_height_width-10, y:size.height-camera_height_width-tabbar_height-40, width: camera_height_width, height: camera_height_width)
        } else {
            tabbar_height = CGFloat(50)
            view_camera.frame = CGRect(x: origin.x+size.width-camera_height_width-10, y:size.height-camera_height_width-tabbar_height-10, width: camera_height_width, height: camera_height_width)
        }
        view_camera.backgroundColor = UIColor.clear
        view.addSubview(view_camera)
        
        let origin_camera_view = view_camera.frame.origin
        let size_camera_view = view_camera.frame.size
        
        let btn_camera = UIButton(frame: CGRect(x:origin_camera_view.x, y:origin_camera_view.y, width: size_camera_view.width, height: size_camera_view.height))
        btn_camera.backgroundColor =  UIColor.clear
        
        view.addSubview(btn_camera)
        btn_camera.addTarget(self, action: #selector(btn_whatsApp(_:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @IBAction func btn_whatsApp (_ sender:UIButton) {
        let urlWhats = "whatsapp://send?phone=+966544296665"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                    let whatsappURL = URL(string: "https://itunes.apple.com/in/app/whatsapp-messenger/id310633997?mt=8")
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL!)
                    }

                }
            }
        }
        
    }
    
    
    
}



extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let color_1 = START_COLOR
            
//            UIColor (red: 146.0/255.0, green: 101.0/255.0, blue: 16.0/255.0, alpha: 0.6)
        let color_2 = hexStringToUIColor(hex: "825a0e")
//            UIColor (red: 253.0/255.0, green: 245.0/255.0, blue: 121.0/255.0, alpha: 0.6)

        let points = [GradientPoint(location: 0, color:color_2),
                      GradientPoint(location:1, color: color_1)]
        
        return UIImage(size:size, gradientPoints: points)!
        
        
//        let veniceImageView = UIImageView(image: #imageLiteral(resourceName: "venice-italy.jpg"))
//        veniceImageView.gradated(gradientPoints: points)
//
//
//        let rect: CGRect = CGRect (x: 0, y: 0, width:size.width+10, height: size.height)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        color.setFill()
//        UIRectFill(rect)
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
//        gradientLayer.endPoint   = CGPoint(x: 0, y: 1)
//        gradientLayer.locations = [0,0.5,1]
//        gradientLayer.colors = [color_up_bottom.cgColor, color_middle.cgColor, color_up_bottom.cgColor]
//
//        let image: UIImage =  gradientLayer.render(in: UIGraphicsGetCurrentContext() as! CGContext) //UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//
//        return image
    }
    
}



struct GradientPoint {
    var location: CGFloat
    var color: UIColor
}



extension UIImage {
    convenience init?(size: CGSize, gradientPoints: [GradientPoint]) {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }       // If the size is zero, the context will be nil.
        guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: gradientPoints.flatMap { $0.color.cgColor.components }.flatMap { $0 }, locations: gradientPoints.map { $0.location }, count: gradientPoints.count) else {
            return nil
        }
        
        context.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions())
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: image)
        defer { UIGraphicsEndImageContext() }
    }
}



extension UIImageView {
    func gradated(gradientPoints: [GradientPoint]) {
        let gradientMaskLayer       = CAGradientLayer()
        gradientMaskLayer.frame     = frame
        gradientMaskLayer.colors    = gradientPoints.map { $0.color.cgColor }
        gradientMaskLayer.locations = gradientPoints.map { $0.location as NSNumber }
        self.layer.insertSublayer(gradientMaskLayer, at: 0)
    }
}
