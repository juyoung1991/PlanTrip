//
//  NewItemViewController.swift
//  PlanTrip
//
//  Created by Ju Young Kim on 6/16/17.
//  Copyright © 2017 Ju Young Kim. All rights reserved.
//

import UIKit
import YelpAPI

class NewItemViewController: UIViewController {
    
    var curr_day:Day? = nil
    
    var my_data:my_data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get_restaurants()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func get_restaurants(){
        let client = YLPClient.authorize(withAppId: "8OYnVkmWi4Mw9vsIOccG2A", secret: "9QeTJDRtrz6P9OlOUpeASPcKkhtv1juGW6hfU75CzXPWgMyAb9w1rk5wpYmzIv5j") { (YLPClient, error) in
            if(error != nil){
                print("error in yelp api")
            }else{
                YLPClient?.search(withLocation: "Chicago", term: "dinner", limit: 30, offset: 0, sort: YLPSortType.highestRated, completionHandler: { (YLPSearch, error) in
                    if(YLPSearch == nil){
                        print("I'm afraid information regarding the current city is not available. :(")
                    }else{
                        print(YLPSearch?.businesses[0].name)
                    }
                    print("YELP API WORKS!")
                })
            }
        }
    }
}
