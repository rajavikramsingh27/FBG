//  Help_ViewController.swift
//  FGB
//  Created by appentus on 6/21/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
var str_help_selected = ""
var str_title = ""



class Help_ViewController: UIViewController {
    @IBOutlet weak var nav_bar:UINavigationBar!
    @IBOutlet weak var lbl_help:UILabel!
    @IBOutlet weak var height_text:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_bar.applyNavGradient()
        
        nav_bar.topItem?.title = str_title
        lbl_help.text = str_help_selected.html2String
        
        height_text.constant = func_height_text(textString: lbl_help.text! as NSString)

        set_gradient_on_label(lbl: lbl_help)
        
    }
    
    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func func_height_text(textString:NSString) -> CGFloat {
        let font = UIFont .systemFont(ofSize: 22)
        let textAttributes = [NSAttributedStringKey.font: font]
        
        let textRect = textString.boundingRect(with: CGSize (width: self.view.frame.size.width-40, height: 10000), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        return textRect.size.height
    }
    
    
}

extension Help_ViewController {
    
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
