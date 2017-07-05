//
//  Extension.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/15/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI

protocol MyCustomCellDelegator {
    
    func callSegueFromRestCell(myData dataobject: my_data)
    
    func callSegueFromAttractCell(myData dataobject: my_data)
    
    func callSegueFromHotelCell(myData dataobject: my_data)
    
    func callSegueFromCollectionCell(myData dataobject: Business)
}

let app_color = UIColor(red: 254.0/255.0, green: 53.0/255.0, blue: 98.0/255.0, alpha: 1.0)

struct Section {
    var day_num: Int!
    var categories: [String]!
    var expanded: Bool!
    
    init(day_num: Int, categories: [String], expanded: Bool = false) {
        self.day_num = day_num
        self.categories = categories
        self.expanded = expanded
    }
}

struct my_data{
    var title:String!
    var curr_day:Day!
    var city:String!
    
    init(title: String, curr_day: Day, city: String){
        self.title = title
        self.curr_day = curr_day
        self.city = city
    }
}

struct Business{
    var name:String?
    var location:String?
    var lat:Double?
    var long:Double?
    var img_url:URL?
    var rating:Double?
    var phone_number:String?
    var business_url:URL?
    var categories:[YLPCategory]?
    var isClosed:Bool?
    var reviewCount:UInt?
    var type:String?
    
    init(name:String?, location:String?, img_url:URL?, rating:Double?, phone_number:String?, business_url:URL?, categories: [YLPCategory]?, isClosed:Bool?, reviewCount:UInt?, lat:Double?, long:Double?, type:String?){
        self.name = name
        self.location = location
        self.img_url = img_url
        self.rating = rating
        self.phone_number = phone_number
        self.business_url = business_url
        self.categories = categories
        self.isClosed = isClosed
        self.reviewCount = reviewCount
        self.lat = lat
        self.long = long
        self.type = type
    }
}

extension UIView {
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
    
}

//https://stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift/33675160#33675160
extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
