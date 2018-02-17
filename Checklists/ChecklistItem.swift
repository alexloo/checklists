//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Alex Loo on 1/16/18.
//  Copyright © 2018 BigCardinal. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    func toggleChecked() {
        checked = !checked
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(dueDate, forKey: "Date")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        aCoder.encode(itemID, forKey: "ItemID")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        dueDate = aDecoder.decodeObject(forKey: "Date") as! Date
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        itemID = aDecoder.decodeInteger(forKey: "ItemID")
        super.init()
    }
    
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    func scheduleNotification() {
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification {
            print("Found an existing notification \(notification)")
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(itemID)])
            center.removeDeliveredNotifications(withIdentifiers: [String(itemID)])
        }
        
        if shouldRemind && dueDate.compare(Date()) != .orderedAscending {
            let center = UNUserNotificationCenter.current()
            
            let content = UNMutableNotificationContent()
            content.body = text
            content.sound = UNNotificationSound.default()
            content.userInfo = ["ItemID": itemID]
            
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            let request = UNNotificationRequest(identifier: String(itemID), content: content, trigger: trigger)
            print("Created and added request for a local notificaiton.")
            center.add(request, withCompletionHandler: { (error) in
                if let error = error {
                    // Something went wrong
                }
            })
        }
    }
    
    func notificationForThisItem() -> UNNotificationRequest? {
        let center = UNUserNotificationCenter.current()
        var requestToReturn: UNNotificationRequest?
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print("request identifier is \(request.identifier)")
                print("this item's identifier is \(self.itemID)")
                if request.identifier == String(self.itemID) {
                    print("Will be returning a request")
                    requestToReturn = request
                    return
                }
            }
        })
        return requestToReturn
    }
}
