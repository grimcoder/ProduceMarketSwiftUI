//
//  PriceEditNewController.swift
//  ProduceOs
//
//  Created by Taras Kovtun on 9/21/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import UIKit

class PriceEditNewController: UIViewController {

    var price : Price = Price(Id: nil, ItemName: "", Price: 0)
    @IBOutlet weak var PriceBox: UITextField!
    @IBOutlet weak var NameBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let segmentedControl = UISegmentedControl(items: items)
        
        
        
        let rightBarButton =
        UIBarButtonItem(barButtonSystemItem:
            UIBarButtonSystemItem.Save , target:
            self, action: "Save")
        
        
        
        navigationItem.setRightBarButtonItem(rightBarButton, animated: true)
        
        PriceBox.text = String(price.Price)
        NameBox.text = price.ItemName
        
    }
    
    func Save(){
        let a = 0
    }
}
