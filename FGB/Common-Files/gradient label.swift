//
//  gradient label.swift
//  FGB
//
//  Created by appentus on 7/2/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation
import UIKit

class gradient_label: UILabel {
    
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
        let colors: [CGColor] = [END_COLOR.cgColor,START_COLOR.cgColor,END_COLOR.cgColor]
        let locs: [CGFloat] = [0.0, 0.5, 1.0]
        // create your gradient
        guard let grad = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locs) else { return }
        // draw gradient
        ctx.drawLinearGradient(grad, start: CGPoint(x: 0, y: bounds.size.height*0.5), end: CGPoint(x:bounds.size.width, y: bounds.size.height*0.5), options: CGGradientDrawingOptions(rawValue: 0))
    }
}
