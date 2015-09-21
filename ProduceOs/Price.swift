//
//  Price.swift
//  ProduceOs
//
//  Created by Taras Kovtun on 9/20/15.
//  Copyright © 2015 Taras Kovtun. All rights reserved.
//

import Foundation

class Price {
    var Price: Double
    var ItemName: String
    var Id: String?
    
    
    init (Id: String?, ItemName: String, Price: Double){
        self.Id = Id
        self.ItemName = ItemName
        self.Price = Price
    }
    
    
}