//
//  LoginViewController.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 05/07/19.
//  Copyright (c) 2019 Israel Alves Santos Junior. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginDisplayLogic: class
{
    func success(userData: Login.UserAccount) -> Void
    func failure(alertController: UIAlertController) -> Void
    func initializeDataLogin(switchLogin: Bool, user: String)
}

class LoginViewController: UIViewController, LoginDisplayLogic, UITextFieldDelegate
{
    @IBOutlet weak var textFieldUser:           UITextField!
    @IBOutlet weak var textFieldPassword:       UITextField!
    @IBOutlet weak var labelTextSave:           UILabel!
    @IBOutlet weak var switchSaveUser:          UISwitch!
    @IBOutlet weak var buttonLogin:             UIButton!
    
    @IBOutlet weak var lcTopLogo:               NSLayoutConstraint!
    @IBOutlet weak var lcLeadingUser:           NSLayoutConstraint!
    @IBOutlet weak var lcTrailingUser:          NSLayoutConstraint!
    @IBOutlet weak var lcSpaceTextSaveSwitch:   NSLayoutConstraint!
    @IBOutlet weak var lcTrailingButtonInfo:    NSLayoutConstraint!
    
    var valueInitialLcTopLogo:                  CGFloat!
    var valueInitialLcLeadingUser:              CGFloat!
    var valueInitialLcTrailingUser:             CGFloat!
    var valueInitialLcSpaceTextSaveSwitch:      CGFloat!
    var valueInitialButtonLogin:                CGFloat!
    var valueInitiallcTrailingButtonInfo:       CGFloat!
    
    var timer: Timer?
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    var userLogin = ""
  
    // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = LoginInteractor()
    let presenter = LoginPresenter()
    let router = LoginRouter()
    
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
    
  }
  
  // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
          let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
          if let router = router, router.responds(to: selector) {
            router.perform(selector, with: segue)
          }
        }        
        
        if segue.destination is StatementViewController {
            let vc = segue.destination as? StatementViewController
            vc?.passwordUser = textFieldPassword.text!
        }        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initializeLayout()
    interactor?.loadDataUserDefault()    
  }
  
  // MARK: Do something
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldUser {
            textFieldPassword.becomeFirstResponder()
        } else {
            view.endEditing(true)
            actionButtons(buttonLogin)
        }
        return true
     }
    
 func initializeLayout() {
    
    buttonLogin.layer.cornerRadius      = 4
    buttonLogin.layer.shadowOffset      = CGSize(width: 0, height: 3)
    buttonLogin.layer.shadowRadius      = 4
    buttonLogin.layer.shadowOpacity     = 0.3
    
    valueInitialLcTopLogo               = lcTopLogo.constant
    valueInitialLcLeadingUser           = lcLeadingUser.constant
    valueInitialLcTrailingUser          = lcTrailingUser.constant
    valueInitialLcSpaceTextSaveSwitch   = lcSpaceTextSaveSwitch.constant
    valueInitialButtonLogin             = buttonLogin.alpha
    valueInitiallcTrailingButtonInfo    = lcTrailingButtonInfo.constant
    
    lcTopLogo.constant                  = -100
    lcLeadingUser.constant              = 17
    lcTrailingUser.constant             = 270
    lcTrailingButtonInfo.constant       = lcTrailingUser.constant
    lcSpaceTextSaveSwitch.constant      = lcLeadingUser.constant
    buttonLogin.alpha                   = 0.0

    view.layoutIfNeeded()
    
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
        print("")
        self.animation()
    }
 }
    
    func initializeDataLogin(switchLogin: Bool, user: String) {
        
        self.switchSaveUser.isOn = switchLogin
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.textFieldUser.text = user
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
    
 @IBAction func actionButtons(_ sender: UIButton) {
    
    switch String(sender.restorationIdentifier!) {
    case "buttonLogin":
        if let userValue = self.textFieldUser.text, let passwordValue = self.textFieldPassword.text {
            userLogin = textFieldUser.text!
            _ = interactor?.validateLogin(user: userValue, password: passwordValue)
        }
    case "buttonInfo":
        interactor?.presentInfo(with: sender.restorationIdentifier!)
    default:
        interactor?.presentInfo(with: sender.restorationIdentifier ?? "")
    }

 }

    func failure(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }

    func success(userData: Login.UserAccount) {
        dismiss(animated: true, completion: nil)
        self.interactor?.saveData(button: switchSaveUser, user: textFieldUser)
        self.performSegue(withIdentifier: "segueSceneAccount", sender: userData)
        textFieldPassword.text?.removeAll()
    }
  
    
 }
