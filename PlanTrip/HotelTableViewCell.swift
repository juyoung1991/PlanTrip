//
//  OtherTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/14/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class HotelTableViewCell: UITableViewCell {

    var delegate:MyCustomCellDelegator!
    
    var days_VC:DaysViewController? = nil
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var hotel_collectionView: UICollectionView!
    
    var curr_day:Day? = nil
    
    var hotel_list:[Hotel] = []

    @IBAction func new_item(_ sender: Any) {
        if(curr_day?.location == nil){
            let alertController = UIAlertController(title: "Oops!", message: "You need to tell us where you're going!", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
                print("You pressed OK")
            }
            alertController.addAction(okAction)
            self.days_VC?.present(alertController, animated: true, completion: nil)
        }else{
            var new_data = my_data(title: "Hotel", curr_day: curr_day!, city: (curr_day?.location!)!)
            if(self.delegate != nil){
                self.delegate.callSegueFromHotelCell(myData: new_data)
            }
        }
    }
}

extension HotelTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hotel_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.hotel_collectionView.dequeueReusableCell(withReuseIdentifier: "hotel_cell", for: indexPath) as! HotelCollectionViewCell
        cell.place_name.text = hotel_list[indexPath.row].name
        cell.img.sd_setImage(with: URL(string: (hotel_list[indexPath.row].img_url!)))
        cell.curr_day = self.curr_day
        cell.curr_hotel = self.hotel_list[indexPath.row]
        cell.days_VC = self.days_VC
        cell.collect_view = self.hotel_collectionView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var curr_hotel:Hotel = self.hotel_list[indexPath.row]
        var curr_business:Business = Business.init(name: curr_hotel.name, location: curr_hotel.location, img_url: URL(string: curr_hotel.img_url!), rating: curr_hotel.rating, phone_number: curr_hotel.phone_number, business_url: URL(string: curr_hotel.business_url!), categories: [], isClosed: curr_hotel.isClosed, reviewCount: UInt(curr_hotel.reviewCnt), lat: curr_hotel.lat, long: curr_hotel.long, type: "Hotel")
        
        self.delegate.callSegueFromCollectionCell(myData: curr_business)
    }
}
