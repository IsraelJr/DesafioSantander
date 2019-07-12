//
//  MainViewController.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import UIKit

class AccountViewControllerMVC: UIViewController {

    @IBOutlet weak var labelNamePerson:  UILabel!
    @IBOutlet weak var labelDataAccount: UILabel!
    @IBOutlet weak var labelBalance:     UILabel!
    @IBOutlet weak var tableviewDetail:  UITableView!
    
    let rateCoercion      = 0.99
    let passwordCoercion  = "1234"
    
    var statementModel: StatementModels!
    var statementList: [StatementModels.StatementList] = []
    var balance: Double = 0.0
    var timer: Timer?
    
    var nameUser        = "José Da Silva"
    var dataAccount     = "2051 / 01.123456-7"
    var passwordUser    = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadStatements()
        labelNamePerson.text = nameUser
        labelDataAccount.text = dataAccount
    }
    
    
    func calculateBalance() {
        for i in 0..<statementList.count {
                balance += statementList[i].value
            }
        labelBalance.text = String(format: "R$ %.2f", balance)
        if passwordUser == passwordCoercion {
            labelBalance.text = String(format: "R$ %.2f", (balance - (balance * rateCoercion)))
        }
    }
    
    
    func loadStatements() {

//        REST.loadStatements(onComplete: { (StatementModelAPI) in
//
//            self.statementList = StatementModelAPI.statementList
//            DispatchQueue.main.async {
//                self.tableviewDetail.reloadData()
//                self.calculateBalance()                
//            }
//            
//        }) { (error) in
//                    print("Deu o erro aqui: \(error)")            
//        }
    }
    

    @IBAction func buttonLogout(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "logout 3.png"), for: UIControl.State.normal)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}


extension AccountViewControllerMVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewDetail.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! DetailTableViewCell
        cell.prepare(with: statementList[indexPath.row])
        return cell
    }
    

}

    
extension AccountViewControllerMVC: UITableViewDelegate {
        
    }
    


