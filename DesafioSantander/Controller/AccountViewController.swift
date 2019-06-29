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
    
    var statements: [StatementModel] = []
    var listStatement: [StatementList] = []
    var balance: Double = 1000.00
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLaunchs()
        calculateBalance()
        
    }
    
    func calculateBalance() {
        
        for i in 0..<statements.count {
            balance += statements[i].statementList[i].value
        }
        labelBalance.text = String(format: "R$ %.2f", balance)
    }
    
    
    
    func loadLaunchs (){
        
        let fileURL = Bundle.main.url(forResource: "launchs.json", withExtension: nil)!
        let jsonData = try! Data(contentsOf: fileURL)
        do {
            statements = try JSONDecoder().decode([StatementModel].self, from: jsonData)
            listStatement.append(StatementList(title: "caiu", desc: "ja", date: "eu", value: 20.9))
        } catch {
            print("Erro na LaunchManager: " + error.localizedDescription)
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
        return listStatement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableviewDetail.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! DetailTableViewCell
//        cell.layer.cornerRadius = 6
//        cell.layer.shadowOffset = CGSize.init(width: 0, height: 5)
//        cell.layer.shadowOpacity = 50
//        cell.layer.borderWidth = 1
        
        for x in listStatement {
            let register =  x.[indexPath.row]
            cell.prepare(with: register)
            
        }
        
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
}

    
extension AccountViewController: UITableViewDelegate {
        
    }
    


