//
//  Splash_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Splash_Diamond_ViewController: UIViewController {
    
    @IBOutlet weak var img_diamong:UIImageView!
    @IBOutlet weak var hand_made_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jeremyGif = UIImage.gifImageWithName("diamond")
        img_diamong.image = jeremyGif
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            if #available(iOS 12.0, *) {
                let login_VC = self.storyboard?.instantiateViewController(withIdentifier: "Walk_Through_ViewController")
                self.present(login_VC!, animated: true, completion: nil)
//            } else {
//                // Fallback on earlier versions
//            }
        }
       
        if hand_made_lbl.applyGradientWith(startColor: START_COLOR, endColor: END_COLOR) {
//            print("Gradient applied!")
        }
        else {
            print("Could not apply gradient")
            hand_made_lbl.textColor = .black
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}



