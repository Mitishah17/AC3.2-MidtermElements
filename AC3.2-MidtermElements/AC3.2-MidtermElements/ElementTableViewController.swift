//
//  ElementTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Miti Shah on 12/8/16.
//  Copyright © 2016 Miti Shah. All rights reserved.
//

import UIKit

class ElementTableViewController: UITableViewController {
    let cache = NSCache<NSString, UIImage> ()
    var elements = [Element]()
    let endpoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"
    let TableViewCellIdentifier = "ElementCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIRequestManager.getData(apiEndpoint: endpoint) {(allData: [Element]?) in
            guard let allData = allData else {return}
            self.elements = allData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elements.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier, for: indexPath)
        let elementChoosen = elements[indexPath.row]
        cell.textLabel?.text = elementChoosen.name
        cell.detailTextLabel?.text = "\(elementChoosen.symbol)(\(elementChoosen.number)) \(elementChoosen.weight)"
        cell.imageView?.image = UIImage(named: "NoImage")
        cell.imageView?.downloadImage(from: elementChoosen.thumbnail, with: cache)
        
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "ElementSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let largestImageString = elements[indexPath.row].largestString
            let title = elements[indexPath.row]
            let destination = segue.destination as! ViewController
            _ = destination.view
            
            destination.imageView.downloadImage(from: largestImageString, with: cache)
            destination.symbolLabel.text = "Symbol: " + String(elements[indexPath.row].symbol)
            destination.numberLabel.text = "Number: " + String(elements[indexPath.row].number)
            destination.weightLabel.text = "Weight: " + String(elements[indexPath.row].weight)
            destination.boilingPointLabel.text = "Boiling Point: " + String(elements[indexPath.row].boilingPoint!)
            destination.meltingPointLabel.text = "Melting Point: " + String(elements[indexPath.row].meltingPoint!)
            
            
            
            
        }
    }
    

}
