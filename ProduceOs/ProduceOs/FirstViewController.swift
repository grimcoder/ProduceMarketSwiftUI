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

class FirstViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseSwiftyJSON({ (request, response, json, error) in
                print(json)
                print(error)
            })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

