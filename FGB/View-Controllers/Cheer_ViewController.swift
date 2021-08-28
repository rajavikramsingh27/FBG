//
//  Cheer_ViewController.swift
//  FGB
//
//  Created by appentus on 6/28/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Cheer_ViewController: UIViewController {
    @IBOutlet weak var lbl_new_Offer:UILabel!
    @IBOutlet weak var lbl_new_msg_from_FGB:UILabel!
    
    @IBOutlet weak var btn_OK:UIButton!
    @IBOutlet weak var view_container:UIView!
    
    @IBOutlet weak var img_special_offer:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set_gradient_on_label(lbl: lbl_new_Offer)
        set_gradient_on_label(lbl: lbl_new_msg_from_FGB)
        set_grad_to_btn(btn: btn_OK)
        
        view_container.layer.cornerRadius = 10
        view_container.clipsToBounds = true
        
        btn_OK.layer.cornerRadius = btn_OK.frame.size.height/2
        btn_OK.clipsToBounds = true
        
        btn_OK.setTitleColor(UIColor.black, for: .normal)
        
        self.view.bringSubview(toFront: view_container)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let jeremyGif = UIImage.gifImageWithName("special_offer")
        img_special_offer.image = jeremyGif
        
        lbl_new_msg_from_FGB.text = str_new_offer_msg
        
        view_container.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options:.allowUserInteraction, animations: {
            self.view_container.transform = CGAffineTransform(scaleX: 1,y: 1)
            self.view_container.transform = .identity
        }, completion: nil)
        
//        UIView.animate(withDuration: 0.5) {
//            self.view_container.transform = CGAffineTransform(scaleX: 1,y: 1)
//        }
    }
    
    @IBAction func btn_OK(_ sender:UIButton) {
//        self.dismiss(animated: true, completion: nil)
        self.view.removeFromSuperview()
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "cheers_stop"), object: nil)
    }
    
}
