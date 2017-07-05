//
//  CategoryTableViewCell.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/14/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit

class BreakfastTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var breakfast_collectionView: UICollectionView!
    
    var curr_day:Day? = nil
    
    var breakfast_list:[Breakfast] = []
}

extension BreakfastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.breakfast_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.breakfast_collectionView.dequeueReusableCell(withReuseIdentifier: "category_cell", for: indexPath) as! CategoryCollectionViewCell
        return cell
    }
}
