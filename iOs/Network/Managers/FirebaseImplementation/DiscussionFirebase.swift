//
//  DiscussionFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 18/11/2019.
//  Copyright © 2019 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public class DiscussionFirebase: DiscussionManager {
    
    var ref = Database.database().reference().child("discussion")
    
    public func list(onSuccess: @escaping ([Discussion]) -> Void, onError: ErrorClosure?) {
        
        self.ref.observe(.value, with: { (snapshot) in
            
            let discussions = snapshot.children
                .compactMap({ Discussion.mapper(snapshot: $0 as! DataSnapshot )})
                .sorted(by: { $0.uid < $1.uid })
            
            onSuccess(discussions)
            
        }) { (error) in
            if let retError = onError {
                retError(error)
            }
        }
        
        
    }
    
}
