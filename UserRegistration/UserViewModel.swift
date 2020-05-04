//
//  UserViewModel.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/04.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
import Combine
import Foundation
import FirebaseFirestore

class UserViewModel: ObservableObject {
    
    
    @Published var currentUser: [String : Any]
    @Published var users:[User]
//    @Published var users = [User]()
 
    init(currentUser: [String : Any]){
        let db = Firestore.firestore()
        self.currentUser = currentUser
        let currentUsergender = currentUser["gender"] as? String ?? ""
        self.users = [User]()
      
        db.collection("Users").addSnapshotListener { (snap, error) in
//           DispatchQueue.main.async {
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
            
//            if let snap = snap {
//                DispatchQueue.global().async {
                for i in snap!.documentChanges {
                    let ref = i.document
                    if currentUsergender != ref.get("gender") as! String{
                  
                    if i.type == .added{
                        let id = ref.get("id") as! String
                        let email = ref.get("email") as! String
                        let name = ref.get("name") as! String
                        let gender = ref.get("gender") as! String
                        let age = ref.get("age") as! String
                        let hometown = ref.get("hometown") as! String
                        let subject = ref.get("subject") as! String
                        let introduction = ref.get("introduction") as! String
                        let studystyle = ref.get("studystyle") as! String
                        let hobby = ref.get("hobby") as! String
                        let personality = ref.get("personality") as! String
                        let work = ref.get("work") as! String
                        let purpose = ref.get("purpose") as! String
                        let photoURL = ref.get("photoURL") as! String
                        let matchRoomId = ref.get("matchRoomId") as? String ?? ""
                        
//                        DispatchQueue.main.async {
                        self.users.append(User(id: id, email: email, name: name, gender: gender, age: age, hometown: hometown, subject: subject, introduction: introduction, studystyle: studystyle, hobby: hobby, personality: personality, work: work, purpose: purpose, photoURL: photoURL, matchRoomId: matchRoomId))
//                        }
                        } //                    print(self.users)
                    }
                }
            }
        }
//    }
    }// init閉じ
//}
    

}
