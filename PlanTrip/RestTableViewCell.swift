//
//  CategoryTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/14/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class RestTableViewCell: UITableViewCell {

    var delegate:MyCustomCellDelegator!
    
    var days_VC:DaysViewController? = nil
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var rest_collectionView: UICollectionView!
    
    @IBOutlet weak var new_item_btn: UIButton!
    var curr_trip:Trip? = nil
    

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
            var new_data = my_data(title: "Restaurant", curr_day: curr_day!, city: (curr_day?.location!)!)
            if(self.delegate != nil){
                self.delegate.callSegueFromRestCell(myData: new_data)
            }
        }
    }
    
    var curr_day:Day? = nil
    
    var rest_list:[Restaurant] = []
}

extension RestTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.rest_list.count)
        return self.rest_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.rest_collectionView.dequeueReusableCell(withReuseIdentifier: "rest_cell", for: indexPath) as! RestCollectionViewCell
        cell.place_name.text = rest_list[indexPath.row].name
        cell.img.sd_setImage(with: URL(string: (rest_list[indexPath.row].img_url!)))
        cell.curr_day = self.curr_day
        cell.curr_rest = self.rest_list[indexPath.row]
        cell.days_VC = self.days_VC
        cell.collect_view = self.rest_collectionView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var curr_rest:Restaurant = self.rest_list[indexPath.row]
        var curr_business:Business = Business.init(name: curr_rest.name, location: curr_rest.location, img_url: URL(string: curr_rest.img_url!), rating: curr_rest.rating, phone_number: curr_rest.phone_number, business_url: URL(string: curr_rest.business_url!), categories: [], isClosed: curr_rest.isClosed, reviewCount: UInt(curr_rest.reviewCnt), lat: curr_rest.lat, long: curr_rest.long, type: "Restaurant")
        
        self.delegate.callSegueFromCollectionCell(myData: curr_business)
    }
}
