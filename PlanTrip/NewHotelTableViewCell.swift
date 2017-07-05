//
//  NewHotelTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/22/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class NewHotelTableViewCell: UITableViewCell {

    @IBOutlet weak var hotel_name: UILabel!
    
    @IBOutlet weak var hotel_category_1: UILabel!
    
    
    @IBOutlet weak var hotel_category_2: UILabel!
    
    @IBOutlet weak var hotel_rating_img: UIImageView!
    
    
    @IBOutlet weak var hotel_reviewCnt: UILabel!
    
    
    @IBOutlet weak var hotel_img: UIImageView!
    
    var hotel_phone_num:String? = ""
    
    var hotel_addr:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
