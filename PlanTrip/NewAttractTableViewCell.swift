//
//  NewAttractTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/22/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class NewAttractTableViewCell: UITableViewCell {

    
    @IBOutlet weak var attract_name: UILabel!
    
    @IBOutlet weak var attract_category_1: UILabel!
    
    @IBOutlet weak var attract_category_2: UILabel!
    
    @IBOutlet weak var attract_rating_img: UIImageView!
    
    @IBOutlet weak var attract_reviewCnt: UILabel!
    
    @IBOutlet weak var attract_img: UIImageView!
    
    var attract_phone_num:String? = ""
    
    var attract_addr:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
