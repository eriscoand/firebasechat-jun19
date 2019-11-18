//
//  Message+Firebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 18/11/2019.
//  Copyright © 2019 ERISCO. All rights reserved.
//

import Foundation
import MessageKit
import Firebase
import FirebaseDatabase

extension Message {
    
    public class func mapper(snapshot: DataSnapshot) -> Message? {
        
        guard let json = snapshot.value as? [String:Any] else{
            return nil
        }
        
        let senderId = json["senderId"] as? String ?? ""
        let displayName = json["displayName"] as? String ?? ""
        let sender = Sender.init(id: senderId, displayName: displayName)
        
        let messageId = json["messageId"] as? String ?? ""
        
        let dateString = json["sentDate"] as? String ?? ""
        let sentDate = Date.fromStringToDate(input: dateString, format: "yyyy-MM-dd HH:mm:ss")
        
        let messageData: MessageData
        
        let type = json["type"] as? String ?? ""
        let value = json["value"] as? String ?? ""
        
        switch type {
        case "text":
            messageData = MessageData.text(value)
            break
        case "image":
            let placeholder = UIImage.init(named: "placeholder")
            messageData = MessageData.photo(placeholder!)
            break
        default:
            messageData = MessageData.text(value)
            break
        }
        
        let message = Message.init(sender: sender, messageId: messageId, sentDate: sentDate, data: messageData, type: type, value: value)
        return message
    }
    
    public class func toDict(message: Message) -> [String: String] {
        
        var dict = [String: String]()
        
        dict["messageId"] = message.messageId
        dict["senderId"] = message.sender.id
        dict["displayName"] = message.sender.displayName
        
        let date = Date.fromDateToString(date: Date(), format: "yyyy-MM-dd HH:mm:ss")
        dict["sentDate"] = date
        
        dict["type"] = message.type
        dict["value"] = message.value
        
        return dict
        
    }
    
}
