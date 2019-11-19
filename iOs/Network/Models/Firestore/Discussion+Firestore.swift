//
//  Discussion+Firebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 18/11/2019.
//  Copyright © 2019 ERISCO. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension Discussion {
    
    class func firestoreMapper(snapshot: QueryDocumentSnapshot) -> Discussion? {
        
        let json = snapshot.data()
        let uid = json["uid"] as? String ?? ""
        let title = json["title"] as? String ?? ""
        
        return Discussion.init(uid: uid, title: title)
        
    }
    
}
