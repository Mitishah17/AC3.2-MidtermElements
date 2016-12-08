//
//  ViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Miti Shah on 12/8/16.
//  Copyright © 2016 Miti Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    
    
    
    //////Could not get the 2nd parameter for post!!!
    
    var postEndpoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    var el = Element!
    var post = [String:Any]()
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.post = ["name" : "Miti Shah"
            fav: el.name]
    }


    

    @IBAction func barButtonAction(_ sender: AnyObject) {
        APIRequestManager.manager.postRequest(endPoint: postEndpoint, data: post)
    }
}

