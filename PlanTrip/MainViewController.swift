//
//  ViewController.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 5/28/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit
import SearchTextField
import IQKeyboardManagerSwift
import CoreData
import FlickrKit

/**
 Source: https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
 **/
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var add_trip: UIButton!
    
    @IBOutlet weak var trip_tableview: UITableView!
    
    @IBOutlet weak var modal_view: UIView!
    
    @IBOutlet weak var country_search: SearchTextField!
    
    @IBOutlet weak var centerPopupConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trip_duration: UITextField!
    
    @IBOutlet weak var trip_name: UITextField!
    
    @IBOutlet weak var error_msg: UILabel!
    
    @IBOutlet weak var continue_btn: UIButton!
    
    @IBOutlet weak var backgroundButton: UIButton!
    
    @IBOutlet weak var nav_item: UINavigationItem!
    
    var trips:[Trip] = []
    
    var selected_trip:Trip? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var countries: [String] {
        let myLanguageId = "en"
        return NSLocale.isoCountryCodes.map {
            return NSLocale(localeIdentifier: myLanguageId).localizedString(forCountryCode: $0) ?? $0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar for current view controller
        self.trip_tableview.layer.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0).cgColor
        fetch_trips()
        init_add_btn()
        init_modal()
        self.country_search.filterStrings(countries)
        self.hideKeyboardWhenTappedAround()
        IQKeyboardManager.sharedManager().enable = true
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func init_navbar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let logo = UIImage(named: "plantrip_logo.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.nav_item.titleView = imageView
    }
    
    @IBAction func close_popup(_ sender: Any) {
        
        self.country_search.text = ""
        self.trip_duration.text = ""
        self.trip_name.text = ""
        
        self.error_msg.isHidden = true
        self.centerPopupConstraint.constant = -1000
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    @IBAction func new_trip(_ sender: Any) {
        self.centerPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
        })
    }
    
    @IBAction func add_trip(_ sender: Any) {
        
        //Error checker
        let duration = self.trip_duration.text
        let name = self.trip_name.text
        let location = self.country_search.text
        
        if(duration == "" || name == "" || location == ""){
            self.error_msg.isHidden = false
        }else{
            
            let trip:Trip = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: self.context) as! Trip
            trip.duration = duration
            trip.location = location
            trip.name = name
            
            for index in 1...Int(duration!)! {
                let day:Day = NSEntityDescription.insertNewObject(forEntityName: "Day", into: self.context) as! Day
                day.day_num = String(index)
                trip.addToTrip_duration(day)
            }
            
            FlickrProvider.fetchPhotosForSearchText(searchText: "\(location!) city", onCompletion: { (error: NSError?, flickrPhotos: [FlickrPhoto]?) -> Void in
                if error == nil {
                    if(flickrPhotos?.count == 0){
                        trip.img_url = nil
                    }else{
                        trip.img_url = String(describing: (flickrPhotos?[0].photoUrl)!)
                    }
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    
                    self.fetch_trips()
                    self.trip_tableview.reloadData()
                    
                } else {
                    if (error!.code == FlickrProvider.Errors.invalidAccessErrorCode) {
                        DispatchQueue.main.async(execute: { () -> Void in
                            print("error")
                        })
                    }
                }
            })
            
            self.country_search.text = ""
            self.trip_duration.text = ""
            self.trip_name.text = ""
            self.error_msg.isHidden = true
            self.centerPopupConstraint.constant = -1000
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.backgroundButton.alpha = 0
            })
        }
    }
    
    func init_modal(){
        self.error_msg.isHidden = true
//        self.modal_view.layer.borderWidth = 2
//        self.modal_view.layer.borderColor = app_color.cgColor
        self.modal_view.layer.shadowColor = UIColor.black.cgColor
        self.modal_view.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.modal_view.layer.shadowOpacity = 0.5
        self.modal_view.layer.shadowRadius = 0.5
        self.modal_view.layer.cornerRadius = 9
        self.continue_btn.layer.cornerRadius = 5
        self.continue_btn.layer.backgroundColor = app_color.cgColor
    }
    
    func init_add_btn(){
        self.add_trip.layer.cornerRadius = 0.5 * self.add_trip.bounds.size.width
        self.add_trip.layer.backgroundColor = app_color.cgColor
        self.add_trip.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.add_trip.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.add_trip.layer.shadowOpacity = 1
        self.add_trip.layer.shadowRadius = 10
        self.add_trip.layer.masksToBounds = false
    }
    
    func fetch_trips(){
        self.trips.removeAll()
        do {
            var request:NSFetchRequest<Trip> = Trip.fetchRequest()
            request.returnsObjectsAsFaults = false
            self.trips = try self.context.fetch(request) as! [Trip]
        } catch {
            print("couldn't fetch trips")
        }
    }
    
    func remove_trip(){
        
    }

    
    /**
     Tableview Functions
     **/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.trips.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 5.0
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
//        return headerView
//    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.trip_tableview.dequeueReusableCell(withIdentifier: "trip_cell", for: indexPath) as! TripTableViewCell
        cell.cell_name.text = self.trips[indexPath.section].name!
        if(self.trips[indexPath.section].img_url != nil){
            cell.cell_image.sd_setImage(with: URL(string: (self.trips[indexPath.section].img_url!)))
        }else{
            cell.cell_image.image = UIImage(named: "no-image-box.png")
        }
        cell.cell_name.adjustsFontSizeToFitWidth = true
        cell.country_name.text = self.trips[indexPath.section].location
//        let border = CALayer()
//        let width = CGFloat(6.0)
//        border.borderColor = UIColor(red: 214.0/255.0, green: 239.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
//        border.frame = CGRect(x: 0, y: 0, width: width, height: cell.main_background.frame.size.height)
//        
//        border.borderWidth = width
//        cell.main_background.layer.addSublayer(border)
//        cell.main_background.layer.masksToBounds = true
        cell.init_cell()
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            //delete the trip by removing from array and reload table
            var curr_trip:Trip = self.trips[indexPath.section]
//            curr_trip.removeFromTrip_duration(curr_trip.trip_duration!)
            self.context.delete(curr_trip)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            fetch_trips()
            self.trip_tableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected_trip = self.trips[indexPath.section]
        
        self.performSegue(withIdentifier: "cell_selected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destViewController = segue.destination as! DaysViewController
        
        destViewController.curr_trip = self.selected_trip
//        destViewController.curr_location = (self.selected_trip?.location)!
    }
    
    
}

