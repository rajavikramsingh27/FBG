//  Constant.swift
//  FGB
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import Foundation
import UIKit
import SVProgressHUD
import MBProgressHUD
import JJHUD

let color_gold = UIColor (red: 210.0/255.0, green: 158.0/255.0, blue: 57.0/255.0, alpha: 1.0)

//let img_default_app = UIImage(named: "place-holder-image.png")?.imageWithColor(color1: UIColor .lightGray)
let img_default_app = UIImage(named: "")?.imageWithColor(color1: UIColor .lightGray)


let k_base_url = "http://appentus.me/FGB/api/Api/"
let k_images_url = "http://appentus.me/FGB/./assets/images/product/"

let email_ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."

let START_COLOR = hexStringToUIColor(hex: "#FDF579")
let END_COLOR = hexStringToUIColor(hex: "#926510")


extension UIViewController {
    func func_ShowHud() {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            self.view.isUserInteractionEnabled = false
    }
    
    func func_ShowHud_Success(with str_Error:String) {
            JJHUD.showSuccess(text: str_Error, delay: 3)
            self.view .isUserInteractionEnabled = false
    }
    
    func func_ShowHud_Error(with str_Error:String) {
            JJHUD.showError(text: str_Error, delay: 3)
            self.view.isUserInteractionEnabled = false
    }
    
    func func_HideHud() {
//            JJHUD.hide()
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.isUserInteractionEnabled = true
    }
    
    func func_IsValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
}



extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}



extension UINavigationBar {
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            color_up_bottom.cgColor,
            color_middle.cgColor,
            color_up_bottom.cgColor
        ]
        gradient.locations = [0, 0.5, 1]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        var frame = bounds
        frame.size.height += self.frame.size.height
        frame.origin.y -= UIApplication.shared.statusBarFrame.size.height
        gradient.frame = frame
        self.layer.addSublayer(gradient)
    }
    
    func applyNavGradient() { //(colours: [UIColor]) { -> UIImage? {
        let colours = [
            color_up_bottom,
            color_middle,
            color_up_bottom
        ]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height + self.frame.origin.y)
        gradientLayer.colors = colours.map { $0.cgColor }
        gradientLayer.locations = [0,0.5,1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.barTintColor = UIColor(patternImage: image!)
//        return image
    }
    
    
    
}



extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}



extension UIView {
    func setTextGradient(startColor:UIColor,endColor:UIColor) {
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.colors = [START_COLOR.cgColor, END_COLOR.cgColor] //[startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
//    func set_grad_on_TEXT(view_gradient:UIView) {
//        let view = UIView(frame: view_gradient.frame)
//        let gradient = CAGradientLayer()
//        gradient.colors = [START_COLOR.cgColor, END_COLOR.cgColor]
//        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
//        gradient.frame = view.bounds
//        view.layer.addSublayer(gradient)
//
//        self.view.addSubview(view)
//        view.addSubview(view_gradient)
//        view.mask = view_gradient
//    }
    
    
    
}



class Gradient_TextView: UITextView {
// MARK: - Colors to create gradient from
    @IBInspectable open var gradientFrom: UIColor?
    @IBInspectable open var gradientTo: UIColor?
    
    override func draw(_ rect: CGRect) {
        // begin new image context to let the superclass draw the text in (so we can use it as a mask)
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        do {
            // get your image context
            guard let ctx = UIGraphicsGetCurrentContext() else { super.draw(rect); return }
            // flip context
            ctx.scaleBy(x: 1, y: -1)
            ctx.translateBy(x: 0, y: -bounds.size.height)
            // get the superclass to draw text
            super.draw(rect)
        }
        // get image and end context
        guard let img = UIGraphicsGetImageFromCurrentImageContext(), img.cgImage != nil else { return }
        UIGraphicsEndImageContext()
        // get drawRect context
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        // clip context to image
        ctx.clip(to: bounds, mask: img.cgImage!)
        // define your colors and locations
        let colors: [CGColor] = [START_COLOR.cgColor, END_COLOR.cgColor]
        let locs: [CGFloat] = [0.0,1.0]
        // create your gradient
        guard let grad = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locs) else { return }
        // draw gradient
        ctx.drawLinearGradient(grad, start: CGPoint(x: 0, y: bounds.size.height*0.5), end: CGPoint(x:bounds.size.width, y: bounds.size.height*0.5), options: CGGradientDrawingOptions(rawValue: 0))
    }
    
}



//extension String {
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }

//}



//extension UILabel {
//    func localized_LABEL(lbl:UILabel) {
//        lbl.text = lbl.text?.localized
//    }
//}
//
//
//
//extension UIButton {
//    func localized_Button(btn:UIButton) {
//        btn.setTitle(btn.currentTitle!.localized, for: .normal)
//    }
//}
//
//
//
//extension UITextField {
//    func localized_PlaceHolder_TextField(textField:UITextField)  {
//        textField.placeholder = textField.placeholder?.localized
//    }
//
//    func localized_TextField(textField:UITextField) {
//        textField.text = textField.text?.localized
//    }
//
//}



extension UIViewController {
    func localized_LABEL(lbl:UILabel) {
        lbl.text = lbl.text?.localized
    }
    
    func localized_Button(btn:UIButton) {
        btn.setTitle(btn.currentTitle!.localized, for: .normal)
    }
    
    func localized_PlaceHolder_TextField(textField:UITextField) {
        textField.placeholder = textField.placeholder?.localized
    }
    
    func localized_TextField(textField:UITextField) {
        textField.text = textField.text?.localized
    }
    
}



extension UIViewController {
    func arabic_digits(_ num:String) ->String {
        if let default_value = UserDefaults.standard.object(forKey: "Language") as? String {
            if default_value == "English" {
                return num
            } else {
                let number = NSNumber(value: Double(num)!)
                let format = NumberFormatter()
                format.maximumFractionDigits = 2
                format.locale = Locale(identifier: "ar")
                let faNumber = format.string(from: number)
                print("arabic no.:- ",faNumber)
                return faNumber!
            }
        } else {
            return num
        }
    }
    
}
