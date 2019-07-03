//
//  MainViewController.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var tableviewDetail: UITableView!
    
    var statementModel: StatementModel!
    var statementList: [StatementList] = []
    var balance: Double = 0.0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadStatements()
        
    }
    
    
    func calculateBalance() {
        for i in 0..<statementList.count {
                balance += statementList[i].value
            }
        labelBalance.text = String(format: "R$ %.2f", balance)
    }
    
    
    func loadStatements() {

//        let fileURL = Bundle.main.url(forResource: "launchs.json", withExtension: nil)!
//        let jsonData = try! Data(contentsOf: fileURL)
//        do {
//            statementModel = try JSONDecoder().decode(StatementModel.self, from: jsonData)
//        } catch {
//            print("Erro na LaunchManager: " + error.localizedDescription)
//        }
        
        REST.loadStatements(onComplete: { (StatementModelAPI) in

            self.statementList = StatementModelAPI.statementList
            DispatchQueue.main.async {
                self.tableviewDetail.reloadData()
                self.calculateBalance()                
            }
                }) { (error) in
                    print("Deu o erro aqui: \(error)")
                }
    }
    

    @IBAction func buttonLogout(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "logout 3.png"), for: UIControl.State.normal)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}


extension AccountViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewDetail.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! DetailTableViewCell
        cell.prepare(with: statementList[indexPath.row])
        return cell
    }
    

}

    
extension AccountViewController: UITableViewDelegate {
        
    }
    


