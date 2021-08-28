//  TableViewCell.swift
//  FGB
//
//  Created by iOS-Appentus on 13/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import SDWebImage
import AVKit
import Photos



class Sign_Up_ViewController: UIViewController {
    @IBOutlet weak var img_profile:UIImageView!
    
    @IBOutlet weak var txt_first_name:UITextField!
    @IBOutlet weak var txt_last_name:UITextField!
    
    @IBOutlet weak var txt_email:UITextField!
    @IBOutlet weak var txt_password:UITextField!
    
    @IBOutlet weak var btn_sign_in:UIButton!
    @IBOutlet weak var btn_sing_up:UIButton!
    
    @IBOutlet weak var hight_password:NSLayoutConstraint!
    
    var is_image = false
    var is_fb = false
    
    var select_country_VC = Select_Country_ViewController()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_first_name.attributedPlaceholder = NSAttributedString(string:"first".localized)
//        txt_last_name.placeholder = "last".localized
//        txt_email.placeholder = "email".localized
//        txt_password.placeholder = "password".localized
        
        
//        txt_first_name.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "first".localized, comment: "")
//        txt_last_name.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "last".localized, comment: "")
//        txt_email.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "email".localized, comment: "")
//        txt_password.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "password".localized, comment: "")
//
        btn_sing_up.setTitle("signup".localized, for: .normal)
        btn_sign_in.setTitle("already".localized, for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_select_Country), name: NSNotification.Name (rawValue: "select_Country"), object: nil)
        
        set_grad_to_btn(btn: btn_sign_in)
        set_grad_to_btn(btn: btn_sing_up)
        
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .authorized {
            print("")
        }
        if photos == .restricted {
            print("")
        }
        
        if photos == .denied {
            print("")
        }
        
        if photos == .authorized {
            print("")
        }
        
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    print(status)
                } else {}
            })
        }
        
        img_profile.backgroundColor = UIColor .clear
        img_profile.layer.cornerRadius = img_profile.frame.size.height/2
        img_profile.clipsToBounds = true
        
        fun_border_color(object: txt_first_name, color: UIColor .white)
        fun_border_color(object: txt_last_name, color: UIColor .white)
        fun_border_color(object: txt_email, color: UIColor .white)
        fun_border_color(object: txt_password, color: UIColor .white)
        
        fun_border_color(object: btn_sign_in, color: UIColor .clear)
        fun_border_color(object: btn_sing_up, color: UIColor .clear)
        
        let first = "first".localized
        let last = "last".localized
        let email = "email".localized
        let password = "password".localized
        
        func_textfield_placeholder(textfield: txt_first_name, placeholder_text: first)
        func_textfield_placeholder(textfield: txt_last_name, placeholder_text: last)
        func_textfield_placeholder(textfield: txt_email, placeholder_text: email)
        func_textfield_placeholder(textfield: txt_password, placeholder_text: password)
        
        txt_first_name.text = Model_Sign_Up.shared.fname
        txt_last_name.text = Model_Sign_Up.shared.lname
        txt_email.text = Model_Sign_Up.shared.email
        
//        img_profile.sd_setShowActivityIndicatorView(true)
//        img_profile.sd_setIndicatorStyle(.gray)
//        img_profile.sd_setImage(with:URL (string: Model_Sign_Up.shared.img_fb_profile), placeholderImage:img_default_app)
        
        if !Model_Sign_Up.shared.img_fb_profile.isEmpty {
            is_image = true
        }
        
        if !Model_Sign_Up.shared.email.isEmpty {
            txt_email.isUserInteractionEnabled = false
            is_fb = true
            hight_password.constant = 0
        } else {
            txt_email.isUserInteractionEnabled = true
            is_fb = false
            hight_password.constant = 44
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    @objc func func_select_Country() {
        self.view.endEditing(true)
        func_update_setting()
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
    
    func fun_border_color(object:UIView,color:UIColor) {
//        if #available(iOS 12.0, *) {
            object.layer.cornerRadius = object.frame.size.height/2
//        } else {
//            // Fallback on earlier versions
//        }
        object.layer.borderColor = color .cgColor
        object.layer.borderWidth = 1
    }
    
    func func_textfield_placeholder(textfield:UITextField,placeholder_text:String) {
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder_text,
                                                             attributes: [NSAttributedStringKey.foregroundColor: color_gold])
    }
    
    @IBAction func btn_open_camers(_ sender:UIButton) {
        func_ChooseImage()
    }
    
    @IBAction func btn_sign_up(_ sender:UIButton) {
        self.view.endEditing(true)
        
        if !func_validatoin() {
            return
        }
        func_customer_signup()
    }
    
    @IBAction func btn_login(_ sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func func_customer_signup() {
        Model_Sign_Up.shared.fname = txt_first_name.text!
        Model_Sign_Up.shared.lname = txt_last_name.text!
        Model_Sign_Up.shared.email = txt_email.text!
        Model_Sign_Up.shared.password = txt_password.text!
//        Model_Sign_Up.shared.customer_profile = img_profile.image!
        
        Model_Sign_Up.shared.device_token = k_FireBaseFCMToken
        
        func_ShowHud()
        Model_Sign_Up.shared.func_customer_signup { (status) in
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
                    self.func_ShowHud_Error(with: Model_Sign_Up.shared.str_message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        self.func_HideHud()
                    })
                }
            }
        }
        
    }
    
    func func_validatoin() -> Bool {
        let is_email_valid = func_IsValidEmail(testStr: txt_email.text!)
        
        if txt_first_name.text!.isEmpty {
            func_ShowHud_Error(with: "Enter first name".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else if txt_last_name.text!.isEmpty {
            func_ShowHud_Error(with: "Enter last name".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else if txt_email.text!.isEmpty {
            func_ShowHud_Error(with: "Enter email".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else if !is_email_valid {
            func_ShowHud_Error(with: "Enter a valid email".localized)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.func_HideHud()
            }
            return false
        } else if !is_fb {
            if txt_password.text!.isEmpty {
                    func_ShowHud_Error(with: "Enter password".localized)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.func_HideHud()
                    }
                    return false
                } else if txt_password.text!.count < 6 {
                    func_ShowHud_Error(with: "Minimum password 6 characters".localized)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.func_HideHud()
                    }
                    return false
                } else {
                    return true
                }
        } else {
            return true
        }
        
    }
    
    
}


extension Sign_Up_ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        
        if textField == txt_first_name {
            if txt_first_name.text!.count > 31 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else if textField == txt_last_name {
            if txt_last_name.text!.count > 31 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else if textField == txt_email {
            if txt_email.text!.count > 31 {
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
    
}



extension Sign_Up_ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func func_camera_permission(completion:@escaping (Bool)->()) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if !granted {
                DispatchQueue.main.async {
                    let alert = UIAlertController (title: "FGB would like to access the camera", message: "FGB needs Camera and PhotoLibrary to complete you profile", preferredStyle: .alert)
                    let yes = UIAlertAction(title: "Don't allow", style: .default) { (yes) in
                        
                    }
                    
                    let no = UIAlertAction(title: "Allow", style: .default) { (yes) in
                        DispatchQueue.main.async {
                            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
                        }
                    }
                    
                    alert.addAction(yes)
                    alert.addAction(no)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            completion(granted)
        }
    }
    
    func func_ChooseImage() {
        
        let alert = UIAlertController(title: "", message: "Please select!", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.func_OpenCamera()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Photos", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.func_OpenGallary()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func func_OpenCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate=self
            
            func_camera_permission { (is_permission) in
                if is_permission {
                    DispatchQueue.main.async {
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
            }
        }
        else
        {
            let alert  = UIAlertController(title: "Warning!", message: "You don't have camera in simulator", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func func_OpenGallary()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate=self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img_profile.image = pickedImage
            img_profile.backgroundColor = UIColor .white
            is_image = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func func_gredient(view:UIView) {
        // create a view with size 400 x 400
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        
        // make it so we can see the view using assistand editor
//        PlaygroundPage.current.liveView = view
//        PlaygroundPage.current.needsIndefiniteExecution = true
        
        // Create a gradient layer
        let gradient = CAGradientLayer()
        
        // gradient colors in order which they will visually appear
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        
        // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // set the gradient layer to the same size as the view
        gradient.frame = view.bounds
        // add the gradient layer to the views layer for rendering
        view.layer.addSublayer(gradient)
        
        // PART 2
        
        // Create a label and add it as a subview
//        let label = UILabel(frame: view.bounds)
//        label.text = "Hello World"
//        label.font = UIFont.boldSystemFont(ofSize: 30)
//        label.textAlignment = .center
//        view.addSubview(label)
        
        view.mask = view
    }
}

