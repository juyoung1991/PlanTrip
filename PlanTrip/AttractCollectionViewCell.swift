//
//  AttractCollectionViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/26/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class AttractCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var place_name: UILabel!
    
    var curr_day:Day? = nil
    
    var curr_attract:Attraction? = nil
    
    var days_VC:UIViewController? = nil
    
    var collect_view:UICollectionView? = nil
    
    @IBAction func delete_attract_element(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "You are about to delete the hottest attraction!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: { action in
            self.curr_attract?.removeFromDay(self.curr_day!)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //reload the entire viewcontroller?
            self.days_VC?.viewWillAppear(true)
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.days_VC?.present(alert, animated: true, completion: nil)
    }
    
}
