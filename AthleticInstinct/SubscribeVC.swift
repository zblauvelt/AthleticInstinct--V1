//
//  SubscriptionVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/2/19.
//  Copyright © 2019 ZackBlauvelt. All rights reserved.
//

import UIKit
import StoreKit

class SubscribeVC: UIViewController {
    
    var requestProd = SKProductsRequest()
    var products = [SKProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        validateProductIdentifiers()
    }
    

}


extension SubscribeVC: SKProductsRequestDelegate {
    
    func validateProductIdentifiers() {
        let productsRequest = SKProductsRequest(productIdentifiers: Set(["com.ZackBlauvelt.AthleticInstinct2.tier1"]))
        
        // Keep a strong reference to the request.
        self.requestProd = productsRequest
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    // SKProductsRequestDelegate protocol method
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        self.products = response.products
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            print(invalidIdentifier)
        }
        
    }
}
