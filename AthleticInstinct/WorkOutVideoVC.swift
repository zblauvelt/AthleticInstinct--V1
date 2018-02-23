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
    var videoid: String!
    var fullURL: String!
    var url = "https://player.vimeo.com/video/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(videoid)
        _ = getVideoURL(url: url, id: videoid)
        
        let requestURL = NSURL(string: fullURL)
        
        let request = NSURLRequest(url: requestURL! as URL)
        
       videoWebView.loadRequest(request as URLRequest)

    }

    //get full URL
    func getVideoURL(url: String, id: String) -> String {
        if let video = videoid {
            fullURL = "\(url)\(video)"
        }
        return fullURL
    }


}
