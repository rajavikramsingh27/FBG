//  Login_ViewController.swift
//  FGB
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.



let color_left_statusBar = hexStringToUIColor(hex: "94680B")
let color_right_statusBar = hexStringToUIColor(hex: "FCF57B")



import UIKit
import FBSDKLoginKit

var is_from_login_sign = false
var is_fb_login = false


//@available(iOS 12.0, *)
class Login_ViewController: UIViewController {
    
    @IBOutlet weak var txt_login:UITextField!
    @IBOutlet weak var txt_password:UITextField!
    
    @IBOutlet weak var btn_sign_in:UIButton!
    @IBOutlet weak var btn_sing_up:UIButton!
    @IBOutlet weak var forgot_pass:UIButton!
    
    @IBOutlet weak var btn_connect_with_fgb:UIButton!
    
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    
    var select_country_VC = Select_Country_ViewController()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txt_login.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "email".localized, comment: "")
//        txt_password.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "password".localized, comment: "")

        let email = "email".localized
        let password = "password".localized

//        forgot_pass.setTitle("".localized, for: .normal)
        btn_connect_with_fgb.setTitle("connectWithFGB".localized, for: .normal)
        forgot_pass.setTitle("forgot".localized, for: .normal)
        
        set_grad_to_btn(btn: btn_sign_in)
        set_grad_to_btn(btn: btn_sing_up)
        set_grad_to_btn(btn: btn_connect_with_fgb)
        
        fun_border_color(object: txt_login, color: UIColor .white, cornerRadius: 20)
        fun_border_color(object: txt_password, color: UIColor .white, cornerRadius: 20)
        fun_border_color(object: btn_sign_in, color: UIColor .clear, cornerRadius: btn_sign_in.frame.size.height/2)
        fun_border_color(object: btn_sing_up, color: UIColor .clear, cornerRadius: btn_sing_up.frame.size.height/2)
        
        func_textfield_placeholder(textfield: txt_login, placeholder_text: email)
        func_textfield_placeholder(textfield: txt_password, placeholder_text: password)
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_select_Country), name: NSNotification.Name (rawValue: "select_Country"), object: nil)
    }
    
    @objc func func_select_Country() {
        func_update_setting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    func fun_border_color(object:UIView,color:UIColor,cornerRadius:CGFloat) {
        object.layer.cornerRadius = cornerRadius
        object.layer.borderColor = color .cgColor
        object.layer.borderWidth = 1
    }
    
    func func_textfield_placeholder(textfield:UITextField,placeholder_text:String) {
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder_text,
                                             attributes: [NSAttributedStringKey.foregroundColor: color_gold])
    }
    
    @IBAction func btn_login(_ sender:UIButton) {
        if !func_validatoin() {
            return
        }
        
        self.view.endEditing(true)
        func_login()
    }
    
    @IBAction func btn_forgot_pwd(_ sender:UIButton) {
        if !func_validatoin_forgot_PWD() {
            return
        }
        
        Model_Login.shared.email = txt_login.text!
        func_forget_password()
    }
    
    @IBAction func btn_login_with_fb(_ sender:UIButton) {
        func_facebook()
    }
    
    @IBAction func btn_sign_up(_ sender:UIButton) {
        Model_Sign_Up.shared.fname = ""
        Model_Sign_Up.shared.lname = ""
        Model_Sign_Up.shared.email = ""
        Model_Sign_Up.shared.img_fb_profile = ""
        
        func_present_sign_Up_VC()
    }
    
    func func_present_sign_Up_VC() {
        let sign_up_VC = storyboard?.instantiateViewController(withIdentifier: "Sign_Up_ViewController") as! Sign_Up_ViewController
        present(sign_up_VC, animated: true, completion: nil)
    }
    
    func func_login() {
        Model_Login.shared.email = txt_login.text!
        Model_Login.shared.password = txt_password.text!
        
        Model_Login.shared.device_token = k_FireBaseFCMToken
        
        func_ShowHud()
        Model_Login.shared.func_login { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    is_from_login_sign = true
                    
                    self.select_country_VC = self.storyboard?.instantiateViewController(withIdentifier: "Select_Country_ViewController") as! Select_Country_ViewController
                    self.view.addSubview(self.select_country_VC.view)
                    self.addChildViewController(self.select_country_VC)
                } else {
                    self.func_ShowHud_Error(with: Model_Login.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        self.func_HideHud()
                    })
                }
            }
        }
        
    }
    
    func func_do_social_login() {
        func_ShowHud()
        Model_Login.shared.func_do_social_login { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
//                    let shop_VC = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
//                    self.present(shop_VC!, animated: true, completion: nil)
                    
                    is_from_login_sign = true
                    
                    self.select_country_VC = self.storyboard?.instantiateViewController(withIdentifier: "Select_Country_ViewController") as! Select_Country_ViewController
                    self.view.addSubview(self.select_country_VC.view)
                    self.addChildViewController(self.select_country_VC)
                } else {
                    self.func_present_sign_Up_VC()
                }
            }
        }
    }
    
    func func_update_setting() {
        func_ShowHud()
        Model_setting.shared.func_update_setting { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
//                    if self.select_country_VC.view != nil {
//                        self.select_country_VC.view.removeFromSuperview()
//                    }
                    
                    let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar_Controller
                    self.present(tabbar, animated: true, completion: nil)
                } else {
                    self.func_ShowHud_Error(with: Model_setting.shared.str_message)
                }
            }
        }
    }
    
    func func_forget_password() {
        func_ShowHud()
        Model_Login.shared.func_forget_password { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    self.func_ShowHud_Success(with: Model_Login.shared.str_message)
                } else {
                    self.func_ShowHud_Error(with: Model_Login.shared.str_message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                    self.func_HideHud()
                })
            }
        }
        
    }
    
    func func_validatoin() -> Bool {
    let is_email = isValidEmail(testStr: txt_login.text!)
     if txt_login.text!.isEmpty {
            func_ShowHud_Error(with: "Enter email".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
     }  else if !is_email {
        func_ShowHud_Error(with: "Enter a valid email".localized)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.func_HideHud()
        }
        return false
     }  else if txt_password.text!.isEmpty {
            func_ShowHud_Error(with: "Enter password".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
     } else {
        return true
        }
    }
    
    func func_validatoin_forgot_PWD() -> Bool {
        let is_email = isValidEmail(testStr: txt_login.text!)
        if txt_login.text!.isEmpty {
            func_ShowHud_Error(with: "Enter email".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        }  else if !is_email {
            func_ShowHud_Error(with: "Enter a valid email".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else {
            return true
        }
    }

    
    
}






//@available(iOS 12.0, *)
extension Login_ViewController {
    func func_facebook() {
        let deletepermission = FBSDKGraphRequest(graphPath: "me/permissions/", parameters: nil, httpMethod: "DELETE")
        deletepermission!.start(completionHandler: {(connection,result,error)-> Void in
            print("the delete permission is \(result)")
        })
        
        fbLoginManager.loginBehavior = .web
//        fbLoginManager.loginBehavior = .systemAccount
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            DispatchQueue.main.async {
                if (error == nil) {
                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
                    if (result?.isCancelled)!{
                        self.func_HideHud()
                        
                        return
                    } else if(fbloginresult.grantedPermissions.contains("email")) {
                        self.getFBUserData()
                        self.fbLoginManager.logOut()
                    } else {
                        self.func_HideHud()
                    }
                }
            }
        }

    }

    

    func getFBUserData() {
        func_ShowHud()
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: {
                (connection, result, error) -> Void in
                DispatchQueue.main.async {
                    if (error == nil) {
                        is_fb_login = true
                        let resultJson : NSDictionary = result as! NSDictionary
                        print(resultJson)

                        let socialID = "\(resultJson["id"] ?? "")"
                        let email = "\(resultJson["email"] ?? "")"

//                        let name = "\(resultJson["name"]!)"
                        let first_name = "\(resultJson["first_name"] ?? "")"
                        let last_name = "\(resultJson["last_name"] ?? "")"

                        let imageDict : NSDictionary = resultJson["picture"] as! NSDictionary
                        let dataOne : NSDictionary = imageDict["data"] as! NSDictionary
                        let imageUrl = "\(dataOne["url"]!)"

                        Model_Sign_Up.shared.fname = first_name
                        Model_Sign_Up.shared.lname = last_name
                        Model_Sign_Up.shared.email = email
                        Model_Sign_Up.shared.social_id = socialID
                        Model_Sign_Up.shared.img_fb_profile = imageUrl

                        Model_Login.shared.social = socialID

                        self.func_HideHud()
                        self.func_do_social_login()
                    } else {
                        self.func_ShowHud_Error(with:"\(error!)")
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            self.func_HideHud()
                        }
                    }
                }
            })
        }
    }

}



//@available(iOS 12.0, *)
extension Login_ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txt_login {
            if txt_login.text!.count > 31 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: email_ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else {
            return true
        }
    }
    
    
    
    func partialGradient(forViewSize size: CGSize, proportion p: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = size
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        self.view.layer.addSublayer(gradientLayer)
        
//        context?.setFillColor()
        
//        context?.setFillColor(UIColor.red.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        
        let c1 = UIColor.yellow.cgColor
        let c2 = UIColor.blue.cgColor
        
        let top = CGPoint(x: 0, y: size.height * (1.0 - p))
        let bottom = CGPoint(x: 0, y: size.height)
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        if let gradient = CGGradient(colorsSpace: colorspace, colors: [c1, c2] as CFArray, locations: [0.0, 1.0]){
            // change 0.0 above to 1-p if you want the top of the gradient orange
            context?.drawLinearGradient(gradient, start: top, end: bottom, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        }
        
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    
}



extension Login_ViewController {
    
    @IBAction func btn_instagram(_ sender:UIButton) {
        let urlWhats = "https://www.instagram.com/fgb_ksa/"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install ")
                    func_present_socialt_VC()
                }
            }
        }
    }
    
    @IBAction func btn_facebook(_ sender:UIButton) {
        let urlWhats = "https://m.facebook.com/fgbksa/"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install ")
                    func_present_socialt_VC()
                }
            }
        }
    }
    
    @IBAction func btn_twitter(_ sender:UIButton) {
        let urlWhats = "https://mobile.twitter.com/FGB_KSA"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install ")
                    func_present_socialt_VC()
                }
            }
        }
    }
    
    @IBAction func btn_whatsup(_ sender:UIButton) {
        let urlWhats = "whatsapp://send?phone=+966544296665"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
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
    
    
    
    @IBAction func btn_pinterest(_ sender:UIButton) {
        let urlWhats = "https://www.pinterest.com/fgb9477/"
        str_social_link = urlWhats
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install ")
                    func_present_socialt_VC()
                }
            }
        }
    }
    
    func func_present_socialt_VC() {
        let social_VC = storyboard?.instantiateViewController(withIdentifier: "Social_ViewController") as! Social_ViewController
        present(social_VC, animated: true, completion: nil)
    }
}
