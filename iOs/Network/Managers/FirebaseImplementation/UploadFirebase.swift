//
//  UploadFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 19/11/2019.
//  Copyright © 2019 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

public class UploadFirebase: UploadManager {
    
    public func save(name: String, image: UIImage, onSuccess: @escaping (String) -> Void, onError: ErrorClosure?) {
        
        let uploadRef = Storage.storage().reference().child(name)
        
        if let imageData = UIImageJPEGRepresentation(image, 0.3){
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            uploadRef.putData(imageData, metadata: metadata) { (metadata, error) in
                
                if let error = error, let onError = onError {
                    onError(error)
                }
                
                uploadRef.downloadURL { (url, error) in
                    
                    if let error = error, let onError = onError {
                        onError(error)
                    }
                    
                    if let url = url {
                        onSuccess(url.absoluteString)
                    }
                    
                    
                }
                
                
            }
        }
        
        
    }
    
}
