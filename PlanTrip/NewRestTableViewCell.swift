//
//  NewRestTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/20/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class NewRestTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rest_img: UIImageView!
    
    @IBOutlet weak var rest_name: UILabel!
    
    @IBOutlet weak var rest_category_2: UILabel!
    
    @IBOutlet weak var rest_category_1: UILabel!
    
    @IBOutlet weak var rest_rating_img: UIImageView!
    
    @IBOutlet weak var rest_reviewCnt: UILabel!
    
    var rest_phone_num:String? = ""
    
    var rest_addr:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
