//
//  DaysViewController.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/5/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit
import CoreData

class DaysViewController: UIViewController, MyCustomCellDelegator {

    var curr_trip:Trip? = nil
    
    @IBOutlet weak var days_tableview: UITableView!
    
    var curr_location:String = ""
    
    var cities:[String] = []
    
    var sections = [Section]()
    
    var days:[Day] = []
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetch_trips()
        self.days_tableview.allowsSelection = false
        self.set_cities()
        
    }
    
    func fetch_trips(){
        self.sections.removeAll()
        do {
            var request:NSFetchRequest<Trip> = Trip.fetchRequest()
            request.returnsObjectsAsFaults = false
            var trips:[Trip] = try self.context.fetch(request) as! [Trip]
            for trip in trips {
                if self.curr_trip?.name == trip.name {
                    self.curr_trip = trip
                    sort_day_arr()
                    self.curr_location = (self.curr_trip?.location)!
                    for i in 1 ... (Int((self.curr_trip?.duration)!)!) {
                        var new_section = Section(day_num: i, categories: ["Restaurant", "Attraction", "Hotel"], expanded: false)
                        self.sections.append(new_section)
                    }
                }
            }
            print("everything is the newly fetched data!")
            self.days_tableview.reloadData()
        } catch {
            print("couldn't fetch trips")
        }
    }
    
    func sort_day_arr(){
        let days_arr = self.curr_trip?.trip_duration?.allObjects as! [Day]
        self.days = days_arr.sorted(by: {$0.day_num! < $1.day_num!})
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func set_cities(){
        let text = try! String(contentsOfFile: Bundle.main.path(forResource: "world-cities", ofType: "txt")!) // Reading File
        let lineArray = text.components(separatedBy: "\n") // Separating Lines
        
        for var i in 0..<lineArray.count - 1
        {
            let wordArray = lineArray[i].components(separatedBy: ",")
            if(wordArray[1] == curr_location){
                self.cities.append(wordArray[0])
            }
        
        }
    }
    
    func callSegueFromRestCell(myData dataobject: my_data) {
        self.performSegue(withIdentifier: "new_rest", sender: dataobject)
    }
    
    func callSegueFromAttractCell(myData dataobject: my_data) {
        self.performSegue(withIdentifier: "new_attract", sender: dataobject)
    }
    
    func callSegueFromHotelCell(myData dataobject: my_data) {
        self.performSegue(withIdentifier: "new_hotel", sender: dataobject)
    }
    
    func callSegueFromCollectionCell(myData dataobject: Business) {
        self.performSegue(withIdentifier: "item_detail", sender: dataobject)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "new_rest"){
            let dest_vc = segue.destination as! NewRestViewController
            dest_vc.my_data = sender as! my_data
        }
        if(segue.identifier == "new_attract"){
            let dest_vc = segue.destination as! NewAttractViewController
            dest_vc.my_data = sender as! my_data
        }
        if(segue.identifier == "new_hotel"){
            let dest_vc = segue.destination as! NewHotelViewController
            dest_vc.my_data = sender as! my_data
        }
        if(segue.identifier == "item_detail"){
            let dest_vc = segue.destination as! DetailsViewController
            dest_vc.curr_business = sender as! Business
            dest_vc.add_to_list_btn.isEnabled = false
            dest_vc.add_to_list_btn.tintColor = UIColor.clear
        }
    }
}
    
extension DaysViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.days_tableview.dequeueReusableCell(withIdentifier: "day_cell", for: indexPath) as! DayTableViewCell
        cell.city_textfield.filterStrings(self.cities)
        cell.city_textfield.text = self.days[indexPath.section].location
        cell.curr_day = self.days[indexPath.section]
        cell.days_VC = self
        cell.currday_tableView.reloadData()
        cell.m13_checkbox.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.sections[indexPath.section].expanded!) {
            return 400.0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CollapsibleTableViewHeader()
        header.customInit(title: "Day \(sections[section].day_num!)", section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
}

extension DaysViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        self.sections[section].expanded = !sections[section].expanded
        
        
        self.days_tableview.beginUpdates()
        for i in 0 ..< 1 {
            self.days_tableview.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        self.days_tableview.endUpdates()
    }
    
}
