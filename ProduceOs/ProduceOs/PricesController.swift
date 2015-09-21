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


class PricesController: UITableViewController , UISearchBarDelegate, UISearchDisplayDelegate {
    
    var prices = [Price]()
    
    var filteredPrices = [Price]()
    
    func loadPrices(){
        prices = [Price]()
        filteredPrices = [Price]()
        Alamofire.request(.GET, "http://127.0.0.1:3001/api/prices", parameters: nil)
            .responseSwiftyJSON({ (request, response, json, error) in
                
                for (key,json):(String, JSON) in json {
                    self.prices.append(Price(Id: json["Id"].stringValue, ItemName: json["ItemName"].stringValue, Price: json["Price"].doubleValue))
                }
                        self.tableView.reloadData()
                self.refreshControl!.endRefreshing()
            })
    }
    
    func deletePrice(id: String){
        Alamofire.request(.DELETE, "http://127.0.0.1:3001/api/prices", parameters: ["id": id])
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredPrices.count
        } else {
            return self.prices.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?
        
        var price : Price
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            price = filteredPrices[indexPath.row]
        } else {
            price = prices[indexPath.row]
        }
        
        // Configure the cell
        cell!.textLabel!.text = price.ItemName + ": " + String(price.Price)
        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell!
    }
    
    @IBAction func NewPrice(sender: AnyObject) {
        let a = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            navigationItem.setLeftBarButtonItem(editButtonItem(), animated: false)
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self,
            action: "handleRefresh:",
            forControlEvents: .ValueChanged)
        
        tableView.addSubview(refreshControl!)
        loadPrices()
    }
    
    func handleRefresh(paramSender: AnyObject){
        loadPrices()
    }
    
    
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath){
            
            if editingStyle == .Delete{
                /* First remove this object from the source */
                let price = prices[indexPath.row]
                prices.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                deletePrice(price.Id!)
                
            }
            
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("priceEdit", sender: tableView)
    }
    

    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func filterContentForSearchText(searchString: String){
        self.filteredPrices = self.prices.filter({( price : Price) -> Bool in
            
        let stringMatch = price.ItemName.rangeOfString(searchString)
            
            return stringMatch != nil
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool){
        self.tableView.reloadData()
    }
    


}

