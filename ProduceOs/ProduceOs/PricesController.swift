//
//  FirstViewController.swift
//  ProduceOs
//
//  Created by Taras Kovtun on 9/14/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON


class PricesController: UITableViewController {
    
    var prices = [Price]()
    
    func loadPrices(){
        Alamofire.request(.GET, "http://127.0.0.1:3001/api/prices", parameters: nil)
            .responseSwiftyJSON({ (request, response, json, error) in
                
                for (key,json):(String, JSON) in json {
                    self.prices.append(Price(Id: json["Id"].stringValue, ItemName: json["ItemName"].stringValue, Price: json["Price"].doubleValue))
                }
                
                
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPrices()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

