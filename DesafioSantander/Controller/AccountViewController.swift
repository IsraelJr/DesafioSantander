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
    
    var launchs: [Launch] = []
    var balance: Double = 1000.00
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLaunchs()
        calculateBalance()
        
    }
    
    func calculateBalance() {
        
        for i in 0..<launchs.count {
            balance += launchs[i].value
        }
        labelBalance.text = String(format: "R$ %.2f", balance)
    }
    
    
    
    func loadLaunchs (){
        
        let fileURL = Bundle.main.url(forResource: "launchs.json", withExtension: nil)!
        let jsonData = try! Data(contentsOf: fileURL)
        do {
            launchs = try JSONDecoder().decode([Launch].self, from: jsonData)
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
        return launchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableviewDetail.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! DetailTableViewCell
//        cell.layer.cornerRadius = 6
//        cell.layer.shadowOffset = CGSize.init(width: 0, height: 5)
//        cell.layer.shadowOpacity = 50
//        cell.layer.borderWidth = 1
        
        
        let launch =  launchs[indexPath.row]
        cell.prepare(with: launch)
        
        return cell
    }
    
}

    
extension AccountViewController: UITableViewDelegate {
        
    }
    


