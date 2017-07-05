//
//  DayTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/14/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit
import SearchTextField
import M13Checkbox



class DayTableViewCell: UITableViewCell {

    
    @IBOutlet weak var city_textfield: SearchTextField!
    
    @IBOutlet weak var currday_tableView: UITableView!
    
    @IBOutlet weak var m13_checkbox: M13Checkbox!
    
    var curr_day:Day? = nil
    
    var days_VC:DaysViewController? = nil

    @IBAction func update_city(_ sender: Any) {
        //add the current city to curr_day location
        if(self.city_textfield.text == ""){
            print("error")
        }else{
            m13_checkbox.isHidden = false
            m13_checkbox.setCheckState(.checked, animated: true)
            curr_day?.location = city_textfield.text
            let wait = DispatchTime.now() + 1.5
            DispatchQueue.main.asyncAfter(deadline: wait) {
                // Your code with delay
                self.m13_checkbox.isHidden = true
                self.m13_checkbox.setCheckState(.unchecked, animated: true)
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.currday_tableView.reloadData()
        }
    }
}

extension DayTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row){
        case 0:
            let cell = self.currday_tableView.dequeueReusableCell(withIdentifier: "restaurant", for: indexPath) as! RestTableViewCell
            cell.delegate = days_VC
            cell.title.text = "Restaurant"
            cell.rest_list = curr_day?.restaurant?.allObjects as! [Restaurant]
            cell.curr_day = curr_day!
            cell.days_VC = self.days_VC
            cell.rest_collectionView.reloadData()
            return cell
        case 1:
            let cell = self.currday_tableView.dequeueReusableCell(withIdentifier: "attraction", for: indexPath) as! AttractionTableViewCell
            cell.delegate = days_VC
            cell.title.text = "Attraction"
            cell.attraction_list = curr_day?.attraction?.allObjects as! [Attraction]
            cell.curr_day = curr_day!
            cell.days_VC = self.days_VC
            cell.attraction_collectionView.reloadData()
            return cell
        
        default:
            let cell = self.currday_tableView.dequeueReusableCell(withIdentifier: "hotel", for: indexPath) as! HotelTableViewCell
            cell.delegate = days_VC
            cell.title.text = "Hotel"
            cell.hotel_list = curr_day?.hotel?.allObjects as! [Hotel]
            cell.curr_day = curr_day!
            cell.days_VC = self.days_VC
            cell.hotel_collectionView.reloadData()
            return cell
        }
    }
}
