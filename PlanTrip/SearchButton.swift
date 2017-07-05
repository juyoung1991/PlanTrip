//
//  SearchButton.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/19/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class SearchButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setTitleColor(app_color, for: .normal)
        
    }

}
