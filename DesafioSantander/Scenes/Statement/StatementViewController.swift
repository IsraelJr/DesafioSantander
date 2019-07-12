//
//  StatementViewController.swift
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

protocol StatementDisplayLogic: class
{
    func displayExtract(value: [StatementModels.StatementList])
    func displayDataAccount(accountUser: Login.UserAccount)
    func failure(alertController: UIAlertController)    
}


class StatementViewController: UIViewController, StatementDisplayLogic
{
    var interactor: StatementBusinessLogic?
    var router: (NSObjectProtocol & StatementRoutingLogic & StatementDataPassing)?
    
    @IBOutlet weak var labelNamePerson:  UILabel!
    @IBOutlet weak var labelDataAccount: UILabel!
    @IBOutlet weak var labelBalance:     UILabel!
    @IBOutlet weak var tableviewDetail:  UITableView!
    
    var passwordUser = ""
    var statementList: [StatementModels.StatementList]  = []
    var timer: Timer?
    
    var dataLogin = Login.UserAccount()
    
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
    let interactor = StatementInteractor()
    let presenter = StatementPresenter()
    let router = StatementRouter()
    
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
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    interactor?.validateCoercion(password: passwordUser)
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
      func doSomething()
      {
        interactor?.doSomething()        
      }
  

    func displayExtract(value: [StatementModels.StatementList])
    {
        statementList = value
        self.tableviewDetail.reloadData()
    }
    
    
    func displayDataAccount(accountUser: Login.UserAccount) {
        var name = accountUser.name
        if accountUser.name == "israel.junior2111@gmail.com" {
            name = "Israel Alves Dos Santos Junior"
        }
        labelNamePerson.text = name
        labelDataAccount.text = "\(accountUser.agency!) / \(accountUser.bankAccount!)"
        labelBalance.text = String(format: "R$ %.2f", accountUser.balance!)
    }
    
    @IBAction func buttonLogout(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "logout 3.png"), for: UIControl.State.normal)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func failure(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
}


extension StatementViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewDetail.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! DetailTableViewCell
        cell.prepare(with: self.statementList[indexPath.row])
        return cell
    }
    
    
}


extension StatementViewController: UITableViewDelegate {
    
}



