//
//  SubscriptionModel.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/6/19.
//  Copyright © 2019 ZackBlauvelt. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class SubscriptionService: NSObject {
    
    static let sessionIdSetNotification = Notification.Name("SubscriptionServiceSessionIdSetNotification")
    static let optionsLoadedNotification = Notification.Name("SubscriptionServiceOptionsLoadedNotification")
    static let restoreSuccessfulNotification = Notification.Name("SubscriptionServiceRestoreSuccessfulNotification")
    static let purchaseSuccessfulNotification = Notification.Name("SubscriptionServiceRestoreSuccessfulNotification")
    
    
    static let shared = SubscriptionService()
    
    var hasReceiptData: Bool {
        return loadReceipt() != nil
    }
    
    var currentSessionId: String? {
        didSet {
            NotificationCenter.default.post(name: SubscriptionService.sessionIdSetNotification, object: currentSessionId)
        }
    }
    
    var currentSubscription: PaidSubscription?
    
    var options: [Subscription]? {
        didSet {
            NotificationCenter.default.post(name: SubscriptionService.optionsLoadedNotification, object: options)
        }
    }
    
    func loadSubscriptionOptions() {
        let monthlySubscription = Bundle.main.bundleIdentifier! + ".tier1"
        
        let productIDs = Set([monthlySubscription])
        print("productID: \(productIDs)")
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
        
    }
    
    func purchase(subscription: Subscription) {
        // TODO: Create payment
    }
    
    func restorePurchases() {
        // TODO: Initiate restore
    }
    
    /*func uploadReceipt(completion: ((_ success: Bool) -> Void)? = nil) {
        if let receiptData = loadReceipt() {
            SelfieService.shared.upload(receipt: receiptData) { [weak self] (result) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let result):
                    strongSelf.currentSessionId = result.sessionId
                    strongSelf.currentSubscription = result.currentSubscription
                    completion?(true)
                case .failure(let error):
                    print("🚫 Receipt Upload Failed: \(error)")
                    completion?(false)
                }
            }
        }
    }*/
    
    private func loadReceipt() -> Data? {
        // TODO: Load the receipt data from the device
        return nil
    }
    
    
    //Checking for receipt data from Apple Store
    func checkForSubscription(vc: UIViewController) {
        //Check if user is Subscribed
        guard SubscriptionService.shared.currentSessionId != nil, SubscriptionService.shared.hasReceiptData else {
            vc.performSegue(withIdentifier: "goToSubscribe", sender: nil)
            return
        }
    }
}



extension SubscriptionService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        options = response.products.map { Subscription(product: $0) }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        if request is SKProductsRequest {
            print("Subscription Options Failed Loading: \(error.localizedDescription)")
        }
    }
}



