//
//  DetailsViewController.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/22/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var business_name: UILabel!
    
    @IBOutlet weak var business_img: UIImageView!
    
    @IBOutlet weak var business_rating_img: UIImageView!
    
    @IBOutlet weak var open_close: UILabel!
    
    @IBOutlet weak var business_addr: UILabel!
    
    @IBOutlet weak var business_phone: UILabel!
    
    @IBOutlet weak var viewMap: GMSMapView!
    
    @IBOutlet weak var yelp_btn: UIButton!
    
    let locationManager=CLLocationManager()
    
    var curr_business:Business? = nil
    
    var firstLocationUpdate: Bool?
    
    var curr_day:Day? = nil
    
    @IBOutlet weak var modal_constraint: NSLayoutConstraint!
    
    @IBOutlet weak var modal_name: UILabel!
    
    @IBOutlet weak var modal_image: UIImageView!
    
    @IBOutlet weak var modal_rating_img: UIImageView!
    
    @IBOutlet weak var detail_scrollView: UIScrollView!
    
    @IBOutlet weak var modal_background_btn: UIButton!
    
    @IBOutlet weak var add_to_list_btn: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print((self.curr_business?.img_url)!)
        init_data()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func call_business(_ sender: Any) {
        if let url = URL(string: "tel://\(self.curr_business?.phone_number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func init_data(){
        self.business_name.text = self.curr_business?.name
        self.business_name.adjustsFontForContentSizeCategory = true
        self.business_img.sd_setImage(with: self.curr_business?.img_url)
        self.business_rating_img.image = set_rating_img(rating: (self.curr_business?.rating)!)
        self.business_img.layer.cornerRadius = self.business_img.frame.size.height / 2
        self.business_img.clipsToBounds = true
        if(self.curr_business?.isClosed)!{
            self.open_close.text = "Closed"
        }else{
            self.open_close.text = "Open"
        }
        self.business_addr.text = self.curr_business?.location
        self.business_addr.adjustsFontForContentSizeCategory = true
        self.business_phone.text = self.curr_business?.phone_number
        
        self.locationManager.requestWhenInUseAuthorization()
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: (self.curr_business?.lat)!, longitude: (self.curr_business?.long)!, zoom: 16.0)
        self.viewMap.camera = camera
        
        self.viewMap.settings.myLocationButton = true
//        self.viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                // Run UI Updates
                self.viewMap.isMyLocationEnabled = true
            }
        }
        
        var position = CLLocationCoordinate2DMake((self.curr_business?.lat)!,(self.curr_business?.long)!)
        var marker = GMSMarker(position: position)
        marker.title = curr_business?.name
        marker.map = viewMap
        
        self.yelp_btn.backgroundColor = UIColor(red: 211.0/255.0, green: 35.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        self.yelp_btn.layer.cornerRadius = 7
        
        //init modal_view
        self.modal_name.text = self.curr_business?.name
        self.modal_image.sd_setImage(with: self.curr_business?.img_url)
        self.modal_rating_img.image = set_rating_img(rating: (self.curr_business?.rating)!)
        
        self.modal_background_btn.isEnabled = false
        self.modal_background_btn.alpha = 0
    }
    
    @IBAction func open_yelp(_ sender: Any) {
            UIApplication.shared.open((self.curr_business?.business_url)!)
    }

    @IBAction func modal_background_clicked(_ sender: Any) {
        self.modal_constraint.constant = -1000
        self.modal_background_btn.alpha = 0
        self.modal_background_btn.isEnabled = false
        self.detail_scrollView.isScrollEnabled = true
    }
    
    @IBAction func add_to_list(_ sender: Any) {
        if(itExists()){
            let alertController = UIAlertController(title: "Oops!", message: "It already exists in your list!", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
                print("You pressed OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
            self.modal_background_btn.isEnabled = true
            self.modal_constraint.constant = 0
            self.modal_background_btn.alpha = 0.5
            self.detail_scrollView.isScrollEnabled = false
        }
    }
    
    func itExists() -> Bool {
        if(curr_business?.type == "Hotel"){
            let hotel_list = self.curr_day?.hotel?.allObjects as! [Hotel]
            for hotel in hotel_list {
                if hotel.name == curr_business?.name{
                    return true
            
                }
            }
        }else if(curr_business?.type == "Restaurant"){
                let rest_list = self.curr_day?.restaurant?.allObjects as! [Restaurant]
                for rest in rest_list {
                    if rest.name == curr_business?.name{
                        return true
                    }
                }
        }else{
            let attract_list = self.curr_day?.attraction?.allObjects as! [Attraction]
            for attract in attract_list {
                if attract.name == curr_business?.name{
                    return true
                }
            }
        }
        return false
    }
    
    @IBAction func modal_yes(_ sender: Any) {
        if(curr_business?.type == "Hotel"){
            var new_hotel:Hotel = NSEntityDescription.insertNewObject(forEntityName: "Hotel", into: self.context) as! Hotel
            new_hotel.business_url = String(describing: (self.curr_business?.business_url)!)
            new_hotel.img_url = String(describing: (self.curr_business?.img_url)!)
            new_hotel.isClosed = (curr_business?.isClosed)!
            new_hotel.lat = (curr_business?.lat)!
            new_hotel.long = (curr_business?.long)!
            new_hotel.location = curr_business?.location
            new_hotel.name = curr_business?.name
            new_hotel.phone_number = curr_business?.phone_number
            new_hotel.rating = (curr_business?.rating)!
            new_hotel.reviewCnt = Int32((curr_business?.reviewCount)!)
            
            new_hotel.addToDay(self.curr_day!)
            
        }else if(curr_business?.type == "Attraction"){
            var new_attract:Attraction = NSEntityDescription.insertNewObject(forEntityName: "Attraction", into: self.context) as! Attraction
            new_attract.business_url = String(describing: (self.curr_business?.business_url)!)
            new_attract.img_url = String(describing: (self.curr_business?.img_url)!)
            new_attract.isClosed = (curr_business?.isClosed)!
            new_attract.lat = (curr_business?.lat)!
            new_attract.long = (curr_business?.long)!
            new_attract.location = curr_business?.location
            new_attract.name = curr_business?.name
            new_attract.phone_number = curr_business?.phone_number
            new_attract.rating = (curr_business?.rating)!
            new_attract.reviewCnt = Int32((curr_business?.reviewCount)!)
            
            new_attract.addToDay(self.curr_day!)
            
        }else{
            var new_rest:Restaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: self.context) as! Restaurant
            new_rest.business_url = String(describing: (self.curr_business?.business_url)!)
            new_rest.img_url = String(describing: (self.curr_business?.img_url)!)
            new_rest.isClosed = (curr_business?.isClosed)!
            new_rest.lat = (curr_business?.lat)!
            new_rest.long = (curr_business?.long)!
            new_rest.location = curr_business?.location
            new_rest.name = curr_business?.name
            new_rest.phone_number = curr_business?.phone_number
            new_rest.rating = (curr_business?.rating)!
            new_rest.reviewCnt = Int32((curr_business?.reviewCount)!)
            
            new_rest.addToDay(self.curr_day!)
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //segue to days viewcontroller
        let viewcontrollers:[UIViewController] = (self.navigationController?.viewControllers)!
        self.navigationController?.popToViewController(viewcontrollers[1], animated: true)
    }
    
    @IBAction func modal_no(_ sender: Any) {
        self.modal_constraint.constant = -1000
        self.modal_background_btn.alpha = 0
        self.modal_background_btn.isEnabled = false
        self.detail_scrollView.isScrollEnabled = true
    }
    
    func set_rating_img(rating:Double) -> UIImage{
        switch rating {
        case 0.0:
            return UIImage(named: "regular_0.png")!
        case 1.0:
            return UIImage(named: "regular_1.png")!
        case 1.5:
            return UIImage(named: "regular_1_half.png")!
        case 2.0:
            return UIImage(named: "regular_2.png")!
        case 2.5:
            return UIImage(named: "regular_2_half.png")!
        case 3.0:
            return UIImage(named: "regular_3.png")!
        case 3.5:
            return UIImage(named: "regular_3_half.png")!
        case 4.0:
            return UIImage(named: "regular_4.png")!
        case 4.5:
            return UIImage(named: "regular_4_half.png")!
        default:
            return UIImage(named: "regular_5.png")!
            
        }
    }
}
