//
//  ACFloatingTextfield.swift
//  ACFloatingTextField
//
//  Created by Er Abhishek Chandani on 31/07/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

@IBDesignable
@objc open class ACFloatingTextfield: UITextField {

    fileprivate var bottomLineView : UIView?
    fileprivate var labelPlaceholder : UILabel?
    fileprivate var labelErrorPlaceholder : UILabel?
    fileprivate var showingError : Bool = false
    
    fileprivate var bottomLineViewHeight : NSLayoutConstraint?
    fileprivate var placeholderLabelHeight : NSLayoutConstraint?
    fileprivate var errorLabelHieght : NSLayoutConstraint?
    
     /// Disable Floating Label when true.
     @IBInspectable open var disableFloatingLabel : Bool = false
    
     /// Shake Bottom line when Showing Error ?
     @IBInspectable open var shakeLineWithError : Bool = true
    
     /// Change Bottom Line Color.
    @IBInspectable open var lineColor : UIColor = UIColor.black {
        didSet{
            self.floatTheLabel()
        }
    }
    
//    Change line color when Editing in textfield
    @IBInspectable open var selectedLineColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0){
        didSet{
            self.floatTheLabel()
        }
    }
    
     /// Change placeholder color.
    @IBInspectable open var placeHolderColor : UIColor = UIColor.lightGray {
        didSet{
            self.floatTheLabel()
        }
    }
    
     /// Change placeholder color while editing.
    @IBInspectable open var selectedPlaceHolderColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0){
        didSet{
            self.floatTheLabel()
        }
    }
    
     /// Change Error Text color.
    @IBInspectable open var errorTextColor : UIColor = UIColor.red{
        didSet{
            self.labelErrorPlaceholder?.textColor = errorTextColor
            self.floatTheLabel()
        }
    }
    
     /// Change Error Line color.
    @IBInspectable open var errorLineColor : UIColor = UIColor.red{
        didSet{
            self.floatTheLabel()
        }
    }
    
    //MARK:- Set Text
    override open var text:String?  {
        didSet {
            if showingError {
                self.hideErrorPlaceHolder()
            }
            floatTheLabel()
        }
    }
    
    override open var placeholder: String? {
        willSet {
            if newValue != "" {
                self.labelPlaceholder?.text = newValue
            }
        }
    }
    
    open var errorText : String? {
        willSet {
            self.labelErrorPlaceholder?.text = newValue
        }
    }
    
    //MARK:- UITtextfield Draw Method Override
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.upadteTextField(frame: CGRect(x:self.frame.minX, y:self.frame.minY, width:rect.width, height:rect.height));
    }
    
    // MARK:- Loading From NIB
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.initialize()
    }
    
    // MARK:- Intialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    }
    
    // MARK:- Text Rect Management
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
    }
    
    //MARK:- UITextfield Becomes First Responder
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.textFieldDidBeginEditing()
        return result
    }
    
    //MARK:- UITextfield Resigns Responder
    override open func resignFirstResponder() -> Bool {
        let result =  super.resignFirstResponder()
        self.textFieldDidEndEditing()
        return result
    }

    //MARK:- Show Error Label
    public func showError() {
        showingError = true;
        self.showErrorPlaceHolder();
    }
    public func hideError() {
        showingError = false;
        self.hideErrorPlaceHolder();
        floatTheLabel()
    }

    public func showErrorWithText(errorText : String) {
        self.errorText = errorText;
        self.labelErrorPlaceholder?.text = self.errorText
        showingError = true;
        self.showErrorPlaceHolder();
    }


}

fileprivate extension ACFloatingTextfield {
    
    //MARK:- ACFLoating Initialzation.
    func initialize() -> Void {
        
        self.clipsToBounds = true
        /// Adding Bottom Line
        addBottomLine()
        
        /// Placeholder Label Configuration.
        addFloatingLabel()
        
        /// Error Placeholder Label Configuration.
        addErrorPlaceholderLabel()
        /// Checking Floatibility
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
        
    }
    
    //MARK:- ADD Bottom Line
    func addBottomLine() {
        
        if bottomLineView?.superview != nil {
            return
        }
        //Bottom Line UIView Configuration.
        bottomLineView = UIView()
        bottomLineView?.backgroundColor = lineColor
        bottomLineView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLineView!)
        
        let leadingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        bottomLineViewHeight = NSLayoutConstraint.init(item: bottomLineView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        
        self.addConstraints([leadingConstraint,trailingConstraint,bottomConstraint])
        bottomLineView?.addConstraint(bottomLineViewHeight!)
    
        self.addTarget(self, action: #selector(self.textfieldEditingChanged), for: .editingChanged)
    }
    
    @objc func textfieldEditingChanged(){
        if showingError {
            hideError()
        }
    }
        
    //MARK:- ADD Floating Label
    func addFloatingLabel(){
        if labelPlaceholder?.superview != nil {
            return
        }
        
        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        
        labelPlaceholder = UILabel()
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.font = UIFont.init(name: (self.font?.fontName ?? "helvetica")!, size: 20)
        labelPlaceholder?.isHidden = true
        labelPlaceholder?.sizeToFit()
        labelPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        
        self.setValue(placeHolderColor, forKeyPath: "_placeholderLabel.textColor")
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }
        
        let leadingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 5)
        let trailingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        placeholderLabelHeight = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15)
        
        self.addConstraints([leadingConstraint,trailingConstraint,topConstraint])
        labelPlaceholder?.addConstraint(placeholderLabelHeight!)
        set_gradient_on_label(lbl: labelPlaceholder!)
    }
    
    
    
    func addErrorPlaceholderLabel() -> Void {

        if self.labelErrorPlaceholder?.superview != nil{
            return
        }
        labelErrorPlaceholder = UILabel()
        labelErrorPlaceholder?.text = self.errorText
        labelErrorPlaceholder?.textAlignment = self.textAlignment
        labelErrorPlaceholder?.textColor = errorTextColor
        labelErrorPlaceholder?.font = UIFont(name: (self.font?.fontName ?? "helvetica")!, size: 20)
        labelErrorPlaceholder?.sizeToFit()
        labelErrorPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelErrorPlaceholder!)

        let trailingConstraint = NSLayoutConstraint.init(item: labelErrorPlaceholder!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: labelErrorPlaceholder!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        errorLabelHieght = NSLayoutConstraint.init(item: labelErrorPlaceholder!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)

        self.addConstraints([trailingConstraint,topConstraint])
        labelErrorPlaceholder?.addConstraint(errorLabelHieght!)
        set_gradient_on_label(lbl: labelPlaceholder!)
    }
    
    func showErrorPlaceHolder() {
        
        bottomLineViewHeight?.constant = 2;
        
        if self.errorText != nil && self.errorText != "" {
            errorLabelHieght?.constant = 15;
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.bottomLineView?.backgroundColor = self.errorLineColor;
                self.layoutIfNeeded()
                }, completion: nil)
        }else{
            errorLabelHieght?.constant = 0;
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.bottomLineView?.backgroundColor = self.errorLineColor;
                self.layoutIfNeeded()
                }, completion: nil)
        }
        
        if shakeLineWithError {
            bottomLineView?.shake()
        }
        
    }
    
    func hideErrorPlaceHolder(){
        showingError = false;
        
        if errorText == nil || errorText == "" {
            return
        }
        
        errorLabelHieght?.constant = 0;
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)

    }

    //MARK:- Float & Resign
    func floatTheLabel() -> Void {
        DispatchQueue.main.async {
            if self.text == "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }else if self.text == "" && !self.isFirstResponder {
                self.resignPlaceholder()
            }else if self.text != "" && !self.isFirstResponder  {
                self.floatPlaceHolder(selected: false)
            }else if self.text != "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }
        }
    }
    
    //MARK:- Upadate and Manage Subviews
    func upadteTextField(frame:CGRect) -> Void {
        self.frame = frame;
        self.initialize()
    }
    
    //MARK:- Float UITextfield Placeholder Label
    func floatPlaceHolder(selected:Bool) -> Void {
        
        labelPlaceholder?.isHidden = false
        if selected {
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.selectedLineColor;
            labelPlaceholder?.textColor = self.selectedPlaceHolderColor;
            bottomLineViewHeight?.constant = 2;
            self.setValue(self.selectedPlaceHolderColor, forKeyPath: "_placeholderLabel.textColor")
        } else {
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
            bottomLineViewHeight?.constant = 1;
//            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.setValue(placeHolderColor, forKeyPath: "_placeholderLabel.textColor")
        }
        
        if disableFloatingLabel == true {
            labelPlaceholder?.isHidden = true
            return
        }
        
        if placeholderLabelHeight?.constant == 15 {
            return
        }
        
        placeholderLabelHeight?.constant = 15;
        labelPlaceholder?.font = UIFont(name: (self.font?.fontName)!, size: 20)
        set_gradient_on_label(lbl: labelPlaceholder!)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
        
    }
    
    //MARK:- Resign the Placeholder
    func resignPlaceholder() -> Void {
        self.setValue(self.placeHolderColor, forKeyPath: "_placeholderLabel.textColor")
        
        bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
        bottomLineViewHeight?.constant = 1;
        
        if disableFloatingLabel {
            labelPlaceholder?.isHidden = true
//            self.labelPlaceholder?.textColor = self.placeHolderColor;
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
            return
        }
        
        placeholderLabelHeight?.constant = self.frame.height

        UIView.animate(withDuration: 0.3, animations: {
            self.labelPlaceholder?.font = self.font
//            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.layoutIfNeeded()
        }) { (finished) in
            self.labelPlaceholder?.isHidden = true
            self.placeholder = self.labelPlaceholder?.text
        }
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidBeginEditing() -> Void {
        if showingError {
            self.hideErrorPlaceHolder()
        }
        if !self.disableFloatingLabel {
            self.placeholder = ""
        }
        self.floatTheLabel()
        self.layoutSubviews()
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidEndEditing() -> Void {
        self.floatTheLabel()
        
//        self.alignmentRectInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width:100, height:self.bounds.height))
        self.leftView = paddingView
        self.leftViewMode = .always

    }
}

//MARK:- Shake
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}




let START_COLOR = hexStringToUIColor(hex: "#FDF579")
let END_COLOR = hexStringToUIColor(hex: "#926510")



func set_gradient_on_label(lbl : UILabel){
    if lbl.applyGradientWith(startColor: START_COLOR, endColor: END_COLOR) {
        //            print("Gradient applied!")
    }
    else {
        print("Could not apply gradient")
        lbl.textColor = .black
    }
}



extension UILabel {
    func applyGradientWith(startColor: UIColor, endColor: UIColor) -> Bool {
        
        var startColorRed:CGFloat = 0
        var startColorGreen:CGFloat = 0
        var startColorBlue:CGFloat = 0
        var startAlpha:CGFloat = 0
        
        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
            return false
        }
        
        var endColorRed:CGFloat = 0
        var endColorGreen:CGFloat = 0
        var endColorBlue:CGFloat = 0
        var endAlpha:CGFloat = 0
        
        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
            return false
        }
        
        let gradientText = self.text ?? ""
        let name:String = NSAttributedStringKey.font.rawValue
        let fontAttributes = [NSAttributedStringKey.font: self.font]
        let textSize: CGSize = gradientText.size(withAttributes: fontAttributes)
        let width:CGFloat = textSize.width
        let height:CGFloat = textSize.height
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return false
        }
        
        UIGraphicsPushContext(context)
        
        let glossGradient:CGGradient?
        let rgbColorspace:CGColorSpace?
        let num_locations:size_t = 2
        let locations:[CGFloat] = [ 0.0, 1.0 ]
        let components:[CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
        rgbColorspace = CGColorSpaceCreateDeviceRGB()
        glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
        let topCenter = CGPoint.zero
        let bottomCenter = CGPoint(x: 0, y: textSize.height)
        context.drawLinearGradient(glossGradient!, start: topCenter, end: bottomCenter, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        UIGraphicsPopContext()
        
        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return false
        }
        
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: gradientImage)
        
        return true
    }
    
}



func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}



