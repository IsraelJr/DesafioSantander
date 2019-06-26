//
//  ViewController.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var labelUser:       UITextField!
    @IBOutlet weak var labelPassword:   UITextField!
    @IBOutlet weak var labelTextSave:   UILabel!
    @IBOutlet weak var switchSaveUser:  UISwitch!
    
    @IBOutlet weak var lcTopLogo:           NSLayoutConstraint!
    @IBOutlet weak var lcTrailingUser:      NSLayoutConstraint!
    @IBOutlet weak var lcLeadingUser:       NSLayoutConstraint!
    @IBOutlet weak var lcTrailingPassword:  NSLayoutConstraint!
    @IBOutlet weak var lcLeadingPassword:   NSLayoutConstraint!
    @IBOutlet weak var buttonLogin:         UIButton!
    
    var timer: Timer?
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeConstraint()
        initializeDataLogin()
    }
    
    
    func initializeConstraint() {
        
        lcTopLogo.constant          = -100
        lcLeadingUser.constant      = 17
        lcTrailingUser.constant     = 270
        buttonLogin.alpha           = 0.0
        labelTextSave.alpha         = 0.0
        
        view.layoutIfNeeded()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            self.animation()
        }
    }
    
    
    func initializeDataLogin() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.labelUser.text = self.ud.string(forKey: "user")
            self.switchSaveUser.isOn = self.ud.bool(forKey: "saveUser")
        }
    }
    
    
    func animation() {
        UIView.animate(withDuration: 1.5){
            self.lcTopLogo.constant          = 36
            self.lcLeadingUser.constant      = 17
            self.lcTrailingUser.constant     = 16
            self.buttonLogin.alpha           = 1.0
            self.labelTextSave.alpha         = 1.0
            
            self.view.layoutIfNeeded()
        }
        
    }

    
    @IBAction func login(_ sender: UIButton) {
        
        if !switchSaveUser.isOn {
            labelUser.text = nil
        }
        
        ud.set(labelUser.text, forKey: "user")
        ud.set(switchSaveUser.isOn, forKey: "saveUser")
        
        dismiss(animated: true, completion: nil)
    }
}

