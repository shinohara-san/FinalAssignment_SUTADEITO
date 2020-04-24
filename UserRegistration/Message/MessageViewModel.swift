//
//  MessageViewModel.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Message: Identifiable {
    var id: String
    var msg: String
    var fromUser: String
    var toUser: String
    var date: Timestamp
}



class MessageViewModel: ObservableObject {
    
    let db = Firestore.firestore()
//    var currentUserId = ""
//    func getCurrentUserId(){
//        db.collection("Users").whereField("email", isEqualTo: firebaseData.session!.email ?? "").getDocuments { (snap, err) in
//            if let err = err{
//                print(err.localizedDescription)
//                return
//            }
//            if let snap = snap{
//                for user in snap.documents{
//                    self.currentUserId = user.data()["id"] as! String
//                }
//            }
//        }
//    }
    
    @Published var messages = [Message]()
    
    init(){
//        getCurrentUserId()
//        .document(currentUserId).collection("messageRoom").order(by: "date")
        db.collection("Messages").order(by: "date").addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                for i in snap.documentChanges {
                    if i.type == .added {
                        let toUser = i.document.get("toUser") as! String
                        let fromUser = i.document.get("fromUser") as! String
                        let message = i.document.get("message") as! String
                        let id = i.document.documentID
                        let date = i.document.get("date") as! Timestamp
                        
                        self.messages.append(Message(id: id, msg: message, fromUser: fromUser, toUser: toUser, date: date))

                    }
                }
            }
        }
    }
    
    
    
    func sendMsg(msg: String, toUser: String, fromUser: String){
        let data1 = [
            "message": msg,
            "toUser": toUser,
            "fromUser": fromUser,
            "date": Timestamp()
            ] as [String : Any]
        
//        let data2  = [
//                   "message": msg,
//                   "toUser": fromUser,
//                   "fromUser": toUser,
//                   "date": Timestamp()
//                   ] as [String : Any]
        
        db.collection("Messages").addDocument(data: data1){ error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            print("メッセージを送信しました")
        }
        
//        db.collection("Messages").document(toUser).collection("messageRoom").addDocument(data: data2){ error in
//            if let err = error {
//                print(err.localizedDescription)
//                return
//            }
//            print("メッセージを送信しました")
//        }
//    }
    
    
}//func
}//class
