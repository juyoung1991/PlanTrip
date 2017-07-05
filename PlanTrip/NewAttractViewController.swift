//
//  NewAttractHotelViewController.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/21/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit
import YelpAPI
import SDWebImage

class NewAttractViewController: UIViewController {
    
    var my_data:my_data? = nil
    
    var term:String? = "Attraction"
    
    @IBOutlet weak var attraction_tableview: UITableView!
    
    var business_list:[Business] = []
    
    var selected_business:Business? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        get_attraction()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func get_attraction(){
        self.business_list.removeAll()
        let client = YLPClient.authorize(withAppId: "8OYnVkmWi4Mw9vsIOccG2A", secret: "9QeTJDRtrz6P9OlOUpeASPcKkhtv1juGW6hfU75CzXPWgMyAb9w1rk5wpYmzIv5j") { (YLPClient, error) in
            if(error != nil){
                print("error in yelp api")
            }else{
                print(self.term)
                YLPClient?.search(withLocation: (self.my_data?.city)!, term: self.term!, limit: 30, offset: 0, sort: YLPSortType.highestRated, completionHandler: { (YLPSearch, error) in
                    if(YLPSearch == nil){
                        let messageLabel = UILabel(frame: CGRect(x: 0,y: 0, width: self.view.bounds.size.width, height:self.view.bounds.size.height))
                        messageLabel.text = "Sorry.\n I'm aftraid we have no information\n regarding the current city."
                        messageLabel.textColor = UIColor.black
                        messageLabel.numberOfLines = 0;
                        messageLabel.textAlignment = .center;
                        messageLabel.font = UIFont(name: "TrebuchetMS", size: 13)
                        messageLabel.sizeToFit()
                        
                        self.attraction_tableview.backgroundView = messageLabel;
                        self.attraction_tableview.separatorColor = UIColor.clear;
                    }else{
                        for business in (YLPSearch?.businesses)! {
                            var addr:String = ""
                            if(business.location.address.count < 1){
                                addr = "\(business.location.city) \(business.location.postalCode)"
                            }else {
                                addr = "\(business.location.address[0]) \(business.location.city) \(business.location.postalCode)"
                            }
                            
                            var new_business:Business = Business.init(name: business.name, location: addr, img_url: business.imageURL, rating: business.rating, phone_number: business.phone, business_url: business.url, categories: business.categories, isClosed: business.isClosed, reviewCount: business.reviewCount, lat: (business.location.coordinate?.latitude)!, long: (business.location.coordinate?.longitude)!, type: "Attraction")
                            
                            self.business_list.append(new_business)
                        }
                        self.attraction_tableview.reloadData()
                        self.attraction_tableview.setContentOffset(CGPoint.zero, animated: true)
                        
                    }
                })
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewAttractViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.business_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.attraction_tableview.dequeueReusableCell(withIdentifier: "new_attract_cell", for: indexPath) as! NewAttractTableViewCell
        var curr_business = business_list[indexPath.row]
        cell.attract_name.text = curr_business.name
        cell.attract_name.adjustsFontForContentSizeCategory = true
        cell.attract_category_1.adjustsFontSizeToFitWidth = true
        cell.attract_category_2.adjustsFontSizeToFitWidth = true
        if curr_business.categories?.count == 1 {
            cell.attract_category_1.text = curr_business.categories?[0].name
            cell.attract_category_2.text = ""
        }else{
            cell.attract_category_1.text = curr_business.categories?[0].name
            cell.attract_category_2.text = curr_business.categories?[1].name
        }
        
        cell.attract_reviewCnt.text = "Based on \(curr_business.reviewCount) Reviews"
        cell.attract_reviewCnt.adjustsFontSizeToFitWidth = true
        cell.attract_rating_img.image = set_rating_img(rating: curr_business.rating!)
        
        cell.attract_img.sd_setImage(with: curr_business.img_url)
        
        cell.attract_addr = curr_business.location!
        
        cell.attract_phone_num = curr_business.phone_number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected_business = self.business_list[indexPath.row]
        self.performSegue(withIdentifier: "attract_detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "attract_detail"){
            let dest_vc = segue.destination as! DetailsViewController
            dest_vc.curr_business = self.selected_business
            dest_vc.curr_day = self.my_data?.curr_day
        }
    }
}
