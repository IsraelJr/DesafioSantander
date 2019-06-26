//
//  TableViewCell.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTypeLaunch: UILabel!
    @IBOutlet weak var labelDateLaunch: UILabel!
    @IBOutlet weak var labelNameAccount: UILabel!
    @IBOutlet weak var labelValueLaunch: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with launch: Launch){
      
        labelTypeLaunch.text  = launch.title
        labelNameAccount.text = launch.desc
        labelDateLaunch.text  = launch.date
        labelValueLaunch.text = launch.valueFormatted

    }

}
