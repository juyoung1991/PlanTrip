//
//  AttractionTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/14/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class AttractionTableViewCell: UITableViewCell {

    var delegate:MyCustomCellDelegator!
    
    var days_VC:DaysViewController? = nil
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var attraction_collectionView: UICollectionView!
    
    var curr_day:Day? = nil
    
    
    var attraction_list:[Attraction] = []

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
            var new_data = my_data(title: "Attraction", curr_day: curr_day!, city: (curr_day?.location!)!)
            if(self.delegate != nil){
                self.delegate.callSegueFromAttractCell(myData: new_data)
            }
        }
    }
    
}

extension AttractionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.attraction_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.attraction_collectionView.dequeueReusableCell(withReuseIdentifier: "attract_cell", for: indexPath) as! AttractCollectionViewCell
        cell.place_name.text = attraction_list[indexPath.row].name
        cell.img.sd_setImage(with: URL(string: (attraction_list[indexPath.row].img_url!)))
        cell.curr_day = self.curr_day
        cell.curr_attract = self.attraction_list[indexPath.row]
        cell.days_VC = self.days_VC
        cell.collect_view = self.attraction_collectionView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var curr_attraction:Attraction = self.attraction_list[indexPath.row]
        var curr_business:Business = Business.init(name: curr_attraction.name, location: curr_attraction.location, img_url: URL(string: curr_attraction.img_url!), rating: curr_attraction.rating, phone_number: curr_attraction.phone_number, business_url: URL(string: curr_attraction.business_url!), categories: [], isClosed: curr_attraction.isClosed, reviewCount: UInt(curr_attraction.reviewCnt), lat: curr_attraction.lat, long: curr_attraction.long, type: "Attraction")
        
        self.delegate.callSegueFromCollectionCell(myData: curr_business)
    }
}
