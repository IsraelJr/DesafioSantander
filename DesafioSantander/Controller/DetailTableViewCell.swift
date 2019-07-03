//
//  TableViewCell.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTypeLaunch:  UILabel!
    @IBOutlet weak var labelDateLaunch:  UILabel!
    @IBOutlet weak var labelNameAccount: UILabel!
    @IBOutlet weak var labelValueLaunch: UILabel!
    @IBOutlet weak var uiviewLanch:      UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        uiviewLanch.layer.shadowColor = UIColor.lightGray.cgColor
        uiviewLanch.layer.shadowOffset = CGSize(width: 0, height: 5 )
        uiviewLanch.layer.shadowOpacity = 0.5
        uiviewLanch.layer.shadowRadius = 6
        uiviewLanch.layer.cornerRadius = 6
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with statement: StatementList){

        labelTypeLaunch.text  = statement.title
        labelNameAccount.text = statement.desc
        labelDateLaunch.text  = statement.dateFormatted
        labelValueLaunch.text = statement.valueFormatted
        
        formattedShadowView(with: statement.value)
    }
    
    private func formattedShadowView(with value: Double) {

        if (value < 0){
            uiviewLanch.layer.shadowColor = UIColor.red.cgColor
        } else {
            uiviewLanch.layer.shadowColor = UIColor.blue.cgColor
        }

    }

}
