//
//  RestButton.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/19/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

//https://stackoverflow.com/questions/26961274/how-can-i-make-a-button-have-a-rounded-border-in-swift

class RestButton: UIButton {

    var clicked:Bool = false
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = app_color.cgColor
        layer.cornerRadius = 5.0
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setTitleColor(app_color, for: .normal)
    }
    
    func btn_pressed(){
        if(!clicked){
            layer.borderWidth = 1.0
            layer.borderColor = app_color.cgColor
            layer.cornerRadius = 5.0
            clipsToBounds = true
            contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            setTitleColor(app_color, for: .normal)
            layer.backgroundColor = UIColor.white.cgColor
        }else{
            layer.borderWidth = 1.0
            layer.borderColor = app_color.cgColor
            layer.cornerRadius = 5.0
            clipsToBounds = true
            contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            setTitleColor(UIColor.white, for: .normal)
            layer.backgroundColor = app_color.cgColor
        }
    }

}
