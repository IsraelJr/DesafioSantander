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
    
    var valueInitialLcTopLogo:              CGFloat!
    var valueInitialLcLeadingUser:          CGFloat!
    var valueInitialLcTrailingUser:         CGFloat!
    var valueInitialLcSpaceTextSaveSwitch:  CGFloat!
    var valueInitialButtonLogin:            CGFloat!
    
    var timer: Timer?
//    var isValidUser: Bool       = false
//    var isValidPassword: Bool   = false
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeConstraint()
        initializeDataLogin()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        REST.loadStatements()
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
//            if !self.textFieldUser.text!.isEmpty {
//                self.isValidUser = true
//            }
            
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
        
//        let isValid: Bool = loginValidate(textField)
        
        if textField == textFieldUser {
//                validationEmail(emailUser: textFieldUser.text ?? "")){
                textFieldPassword.becomeFirstResponder()
//            return isValid
            
        } else {
            
//            if(validationPassword(passwordUser: textFieldPassword.text ?? "")){
            view.endEditing(true)
            login(buttonLogin)
//                return isValid
            }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        
        if validationEmail(emailUser: textFieldUser.text ?? "") &&
            validationPassword(passwordUser: textFieldPassword.text ?? "") {
            
//        if loginValidate(textFieldUser) && loginValidate(textFieldPassword) {
        
//            isValidUser     = false
//            isValidPassword = false
//
            dismiss(animated: true, completion: nil)
        
            saveUserDefault()
        
            performSegue(withIdentifier: "segueSceneAccount", sender: nil)
        
        }
    }
    
    func saveUserDefault() {
        
        if !switchSaveUser.isOn {
            textFieldUser.text = nil
        }
        
        ud.set(textFieldUser.text, forKey: "user")
        ud.set(switchSaveUser.isOn, forKey: "saveUser")
        textFieldPassword.text = nil
        
    }
    
//    func loginValidate(_ textField: UITextField) -> Bool {
//
//        if textField == textFieldUser {
//
//            if (validationEmail(emailUser: textFieldUser.text ?? "")){
////                self.isValidUser = true
////                return isValidUser
//                return true
//            }
//
//        } else {
//
//            if(validationPassword(passwordUser: textFieldPassword.text ?? "")){
////                self.isValidPassword = true
////                return isValidPassword
//                return true
//            }
//        }
//        return false
//    }
    
    
}
