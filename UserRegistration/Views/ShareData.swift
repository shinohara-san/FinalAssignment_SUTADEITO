//
//  ShareData.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import FirebaseStorage

class ShareData:ObservableObject{
    @Published var currentUserData = [String : Any]()
    @Published var imageURL = ""
//    @Published var date = Date()
    func loadImageFromFirebase(){
        //        FILE_NAMEがあれば画面表示の際にurlが取得されFirebaseImageViewで画像が表示されている
        let storage = Storage.storage().reference(withPath: "images/pictureOf_\(String(describing: self.currentUserData["email"] ?? ""))")
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                print("Error: loadImageFromFirebase")
                return
            }
//            print("Download success")
            self.imageURL = "\(url!)"
        }
    }
    
}
