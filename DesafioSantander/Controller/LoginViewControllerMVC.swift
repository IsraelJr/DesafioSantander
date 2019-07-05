//
//  ViewController.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import UIKit


class LoginViewControllerMVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelTextSave:   UILabel!
    @IBOutlet weak var switchSaveUser:  UISwitch!
    
    @IBOutlet weak var lcTopLogo:               NSLayoutConstraint!
    @IBOutlet weak var lcLeadingUser:           NSLayoutConstraint!
    @IBOutlet weak var lcTrailingUser:          NSLayoutConstraint!
    @IBOutlet weak var lcSpaceTextSaveSwitch:   NSLayoutConstraint!
    @IBOutlet weak var lcTrailingButtonInfo:    NSLayoutConstraint!
    @IBOutlet weak var buttonLogin:             UIButton!
    
    var valueInitialLcTopLogo:              CGFloat!
    var valueInitialLcLeadingUser:          CGFloat!
    var valueInitialLcTrailingUser:         CGFloat!
    var valueInitialLcSpaceTextSaveSwitch:  CGFloat!
    var valueInitialButtonLogin:            CGFloat!
    var valueInitiallcTrailingButtonInfo:   CGFloat!
    
    var timer: Timer?
//    var isValidUser: Bool       = false
//    var isValidPassword: Bool   = false
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeConstraint()
        initializeDataLogin()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        REST.loadStatements()
//    }
    
    
    func initializeConstraint() {
        
        valueInitialLcTopLogo               = lcTopLogo.constant
        valueInitialLcLeadingUser           = lcLeadingUser.constant
        valueInitialLcTrailingUser          = lcTrailingUser.constant
        valueInitialLcSpaceTextSaveSwitch   = lcSpaceTextSaveSwitch.constant
        valueInitialButtonLogin             = buttonLogin.alpha
        valueInitiallcTrailingButtonInfo    = lcTrailingButtonInfo.constant
        
        lcTopLogo.constant              = -100
        lcLeadingUser.constant          = 17
        lcTrailingUser.constant         = 270
        lcTrailingButtonInfo.constant   = lcTrailingUser.constant
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
            self.lcTrailingButtonInfo.constant  = self.valueInitiallcTrailingButtonInfo
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
            actionButtons(buttonLogin)
//                return isValid
            }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func actionButtons(_ sender: UIButton) {
      
        if sender.restorationIdentifier == "buttonLogin" {
            
            if (isValidEmail(emailUser: textFieldUser.text ?? "") || isValidCPF(cpfUser: textFieldUser.text ?? "")) &&
                (isValidPassword(passwordUser: textFieldPassword.text ?? "") || textFieldPassword.text == "1234") {
                
                dismiss(animated: true, completion: nil)
                
                performSegue(withIdentifier: "segueSceneAccount", sender: nil)
                
                let viewControllerAccount = storyboard?.instantiateViewController(withIdentifier: "AccountViewControllerMVC") as! AccountViewControllerMVC
                
//                viewControllerAccount.labelNamePerson.text = textFieldUser.text ?? "Teste"
                navigationController?.pushViewController(viewControllerAccount, animated: true)
                
            } else {
                showAlert(sender.restorationIdentifier!)
                
            }
        } else {
            print("Botão de informação")
            showAlert(sender.restorationIdentifier!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is AccountViewControllerMVC {
            let vc = segue.destination as? AccountViewControllerMVC
            if textFieldUser.text == "israel.junior2111@gmail.com" {
                vc?.nameUser        = "Israel Alves Dos Santos Junior"
                vc?.dataAccount     = "0642 / 01.035063-2"
            }
            vc?.passwordUser    = textFieldPassword.text!
        }
        saveUserDefault()
    }
    
    func saveUserDefault() {
        
        if !switchSaveUser.isOn {
            textFieldUser.text = nil
        }
        
        ud.set(textFieldUser.text, forKey: "user")
        ud.set(switchSaveUser.isOn, forKey: "saveUser")
        textFieldPassword.text = nil
        
    }

    
    func showAlert(_ with: String) {
        
        var message: UIAlertController? = nil
        var textAlert = ""
        var textTitleAlert = ""
        
        switch with {
        case "buttonLogin":
            print("p")
            textTitleAlert = "Falha no Login"
            textAlert = "Dados de Login Incorretos."
            
        case "buttonInfo":
            textTitleAlert = "Informação"
            textAlert = "Digite seu E-Mail ou CPF."
        
        default:
            print("Valor Default identifica Sucesso")
        }
        
        message = UIAlertController(title: textTitleAlert, message: textAlert, preferredStyle: .alert)
        
        message!.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")}))
        
        present(message!, animated: true, completion: nil)
    }
}
