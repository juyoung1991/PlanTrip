//
//  TripTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/2/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_name: UILabel!
    
    @IBOutlet weak var cell_image: UIImageView!
    
    @IBOutlet weak var outer_border_view: UIView!
    
    @IBOutlet weak var main_background: UIView!
    
    @IBOutlet weak var country_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func init_cell(){
//        self.main_background.layer.cornerRadius = 8
//        
//        self.cell_image.layer.cornerRadius = self.cell_image.frame.size.height / 2
//        self.cell_image.clipsToBounds = true
//        
//        self.outer_border_view.layer.cornerRadius = self.outer_border_view.frame.size.height / 2
//        self.outer_border_view.layer.shadowColor = UIColor.black.cgColor
//        self.outer_border_view.layer.shadowOpacity = 1
//        self.outer_border_view.layer.shadowOffset = CGSize(width: -1, height: 1)
//        self.outer_border_view.layer.shadowRadius = 2
        
        self.country_name.textColor = UIColor.lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    

}
