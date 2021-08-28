

import UIKit


let color_up_bottom = hexStringToUIColor(hex: "8B570B")
let color_middle = hexStringToUIColor(hex: "FAF067")

//

@IBDesignable
class GradientButton: UIButton {
    @IBInspectable var startColor:   UIColor = color_up_bottom { didSet { updateColors() }}
    @IBInspectable var mid_Color:UIColor = color_middle { didSet { updateColors() }}
    @IBInspectable var endColor:UIColor = color_up_bottom { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0 { didSet { updateLocations() }}
    @IBInspectable var mid_Location:Double =   0.5 { didSet { updateLocations() }}
    @IBInspectable var endLocation:Double =   1 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { return CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }

    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber,mid_Location as NSNumber, endLocation as NSNumber]
    }

    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, mid_Color.cgColor, endColor.cgColor]
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }

}

@IBDesignable
class GradientLabel: UILabel {
    @IBInspectable var startColor:   UIColor = color_up_bottom { didSet { updateColors() }}
    @IBInspectable var mid_Color:UIColor = color_middle { didSet { updateColors() }}
    @IBInspectable var endColor:UIColor = color_up_bottom { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0 { didSet { updateLocations() }}
    @IBInspectable var mid_Location:Double =   0.5 { didSet { updateLocations() }}
    @IBInspectable var endLocation:Double =   1 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { return CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }

    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber,mid_Location as NSNumber, endLocation as NSNumber]
    }

    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, mid_Color.cgColor, endColor.cgColor]
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

@IBDesignable
class GradientView: UIView {
    @IBInspectable var startColor:   UIColor = color_up_bottom { didSet { updateColors() }}
    @IBInspectable var mid_Color:UIColor = color_middle { didSet { updateColors() }}
    @IBInspectable var endColor:UIColor = color_up_bottom { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0 { didSet { updateLocations() }}
    @IBInspectable var mid_Location:Double =   0.5 { didSet { updateLocations() }}
    @IBInspectable var endLocation:Double =   1 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { return CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }

    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber,mid_Location as NSNumber, endLocation as NSNumber]
    }

    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, mid_Color.cgColor, endColor.cgColor]
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}



@IBDesignable
class ShadowView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var color_border: UIColor? = UIColor.clear
    @IBInspectable var border_width: Float = 1

    @IBInspectable var width: Int = 0
    @IBInspectable var height: Int = 1
    @IBInspectable var color: UIColor? = UIColor.black
    @IBInspectable var opacity: Float = 0.1
    @IBInspectable var radius: Float = 0.1

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = color?.cgColor
        layer.shadowOffset = CGSize(width: width, height: height);
        layer.shadowOpacity = opacity
        layer.shadowRadius = CGFloat(radius)
        layer.shadowPath = shadowPath.cgPath
        layer.borderColor = color_border?.cgColor
        layer.borderWidth = CGFloat(border_width)
    }

}




@IBDesignable
class Border_View: UIView {
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var color_border: UIColor? = UIColor.clear
    @IBInspectable var border_width: Float = 1

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = color_border?.cgColor
        layer.borderWidth = CGFloat(border_width)
        self.clipsToBounds = true
    }

}



@IBDesignable
class Gradient_Status_Bar: UIView {
    @IBInspectable var startColor:   UIColor = color_right_statusBar { didSet { updateColors() }}
    @IBInspectable var endColor:UIColor = color_left_statusBar { didSet { updateColors() }}
    //    @IBInspectable var startLocation: Double =   0 { didSet { updateLocations() }}
    //    @IBInspectable var endLocation:Double =   1 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { return CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [0,0.4, 0.8]
    }
    
    func updateColors() {
        gradientLayer.colors = [endColor.cgColor,startColor.cgColor,endColor.cgColor]
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }

}



//class func setLanguage(_ language: String) {
//    var onceToken: Int
//    if (onceToken == 0) {
//        /* TODO: move below code to a static variable initializer (dispatch_once is deprecated) */
//        object_setClass(Bundle.main, BundleEx.self)
//    }
//    onceToken = 1
//    objc_setAssociatedObject(Bundle.main, bundle, language ? Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")) : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//}
