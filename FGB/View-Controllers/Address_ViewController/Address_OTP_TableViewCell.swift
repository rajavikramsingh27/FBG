
//  Address_OTP_TableViewCell.swift
//  FGB

//  Created by iOS-Appentus on 24/04/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit
import KWVerificationCodeView

class Address_OTP_TableViewCell: UITableViewCell {
    @IBOutlet weak var codeView: KWVerificationCodeView!
    @IBOutlet weak var btn_send_otp: UIButton!
    @IBOutlet weak var btn_verify_otp: UIButton!
    @IBOutlet weak var lbl_enter_otp:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        set_grad_to_btn(btn: btn_send_otp)
        set_grad_to_btn(btn: btn_verify_otp)
        set_gradient_on_label(lbl: lbl_enter_otp)
        
        lbl_enter_otp.text = "enterotp".localized
        btn_verify_otp.setTitle("verify".localized, for:.normal)
        btn_send_otp.setTitle("send".localized, for:.normal)
        btn_send_otp.setTitle("resendotp".localized, for:.selected)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }

}
