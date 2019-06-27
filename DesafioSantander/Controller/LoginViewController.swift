//
//  ViewController.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelTextSave:   UILabel!
    @IBOutlet weak var switchSaveUser:  UISwitch!
    
    @IBOutlet weak var lcTopLogo:               NSLayoutConstraint!
    @IBOutlet weak var lcLeadingUser:           NSLayoutConstraint!
    @IBOutlet weak var lcTrailingUser:          NSLayoutConstraint!
    @IBOutlet weak var lcSpaceTextSaveSwitch:   NSLayoutConstraint!
    @IBOutlet weak var buttonLogin:             UIButton!
    
    var timer: Timer?
    
    var valueInitialLcTopLogo:              CGFloat!
    var valueInitialLcLeadingUser:          CGFloat!
    var valueInitialLcTrailingUser:         CGFloat!
    var valueInitialLcSpaceTextSaveSwitch:  CGFloat!
    var valueInitialButtonLogin:            CGFloat!
    
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeConstraint()
        initializeDataLogin()
        
    }
    
    
    func initializeConstraint() {
        
        valueInitialLcTopLogo               = lcTopLogo.constant
        valueInitialLcLeadingUser           = lcLeadingUser.constant
        valueInitialLcTrailingUser          = lcTrailingUser.constant
        valueInitialLcSpaceTextSaveSwitch   = lcSpaceTextSaveSwitch.constant
        valueInitialButtonLogin             = buttonLogin.alpha
        
        lcTopLogo.constant              = -100
        lcLeadingUser.constant          = 17
        lcTrailingUser.constant         = 270
        lcSpaceTextSaveSwitch.constant  = lcLeadingUser.constant
        buttonLogin.alpha               = 0.0
        
        buttonLogin.layer.cornerRadius = 4
        
        view.layoutIfNeeded()

        self.switchSaveUser.isOn = self.ud.bool(forKey: "saveUser")
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.animation()
        }
    }
    
    
    
    func initializeDataLogin() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.textFieldUser.text = self.ud.string(forKey: "user")
            //self.login(self.buttonLogin)
        }
    }
    
    
    func animation() {
        UIView.animate(withDuration: 1.5){
            self.lcTopLogo.constant             = self.valueInitialLcTopLogo
            self.lcLeadingUser.constant         = self.valueInitialLcLeadingUser
            self.lcTrailingUser.constant        = self.valueInitialLcTrailingUser
            self.lcSpaceTextSaveSwitch.constant = self.valueInitialLcSpaceTextSaveSwitch
            self.buttonLogin.alpha              = self.valueInitialButtonLogin
            
            self.view.layoutIfNeeded()
        }
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == textFieldUser {
            
            if (validationEmail(emailUser: textFieldUser.text ?? "")){
                textFieldPassword.becomeFirstResponder()
            }
            
        } else {
            
            if(validationPassword(passwordUser: textFieldPassword.text ?? "")){
                login(buttonLogin)
            }
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        
            dismiss(animated: true, completion: nil)
        
            saveUserDefault()
        
            performSegue(withIdentifier: "segueSceneAccount", sender: nil)
        
    }
    
    func saveUserDefault() {
        
        if !switchSaveUser.isOn {
            textFieldUser.text = nil
        }
        
        ud.set(textFieldUser.text, forKey: "user")
        ud.set(switchSaveUser.isOn, forKey: "saveUser")
        textFieldPassword.text = nil
        
    }
}
