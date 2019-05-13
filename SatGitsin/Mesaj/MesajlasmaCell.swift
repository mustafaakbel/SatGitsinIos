//
//  MesajlasmaCell.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 8.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

import UIKit

class MesajlasmaCell: UITableViewCell {

    @IBOutlet weak var mesajTarih: UILabel!
    @IBOutlet weak var mesajIcerik: UILabel!
    @IBOutlet weak var mesajIsim: UILabel!
    @IBOutlet weak var mesajFoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
