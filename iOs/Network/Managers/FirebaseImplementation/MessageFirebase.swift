//
//  MessageFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 18/11/2019.
//  Copyright © 2019 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import MessageKit

public class MessageFirebase: MessageManager {
    
    public var discussion: Discussion
    var ref: DatabaseReference
    
    public required init(discussion: Discussion) {
        self.discussion = discussion
        self.ref = Database.database().reference().child("messages").child(self.discussion.uid)
    }
    
    public func list(onSuccess: @escaping ([Message]) -> Void, onError: ErrorClosure?) {
        
        self.ref.observe(.value, with: { (snapshot) in
            
            let messages = snapshot.children
                .compactMap({ Message.mapper(snapshot: $0 as! DataSnapshot )})
                .sorted(by: { $0.sentDate < $1.sentDate })
            
            onSuccess(messages)
            
        }) { (error) in
            if let retError = onError {
                retError(error)
            }
        }
        
    }
    
    public func add(message: Message, onSuccess: @escaping () -> Void, onError: ErrorClosure?) {
        
        let child = Message.toDict(message: message)
        
        self.ref.child(message.messageId).updateChildValues(child) { (error, _ ) in
            
            if let err = error, let retError = onError {
                retError(err)
            }
            
            onSuccess()
            
        }
        
        
    }
    
    
}
