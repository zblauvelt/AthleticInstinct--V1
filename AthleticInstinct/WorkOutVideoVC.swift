//
//  WorkOutVideoVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 11/6/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit

class WorkOutVideoVC: UIViewController {

    @IBOutlet weak var videoWebView: UIWebView!
    
    var url = "https://player.vimeo.com/video/162294438"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = NSURL(string: url)
        
        let request = NSURLRequest(url: requestURL! as URL)
        
       videoWebView.loadRequest(request as URLRequest)

    }


    


}
