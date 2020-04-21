//
//  ShareData.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

class ShareData:ObservableObject{
    
    let db = Firestore.firestore()
    let datas = firebaseData
    
    @Published var currentUserData = [String : Any]()
    
    @Published var allUsers : [User] = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")] //ScrollViewには最初に配列に初期値を設定する必要あり
    
    @Published var favoriteUserIds = [String]()
    
    @Published var favoriteUsers: [User] = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
    
    @Published var MatchUsers: [User] = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
    
    @Published var imageURL = ""
    
    func loadImageFromFirebase(path: String){
        //        FILE_NAMEがあれば画面表示の際にurlが取得されFirebaseImageViewで画像が表示されている
        let storage = Storage.storage().reference(withPath: path)
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
    
    func getAllUsers(){
        self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除
        let dbCollection = Firestore.firestore().collection("Users")
        //        .whereField("gender", isEqualTo: chosenGender).
        dbCollection.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for user in querySnapshot!.documents {
                    if user.data()["gender"] as? String != self.currentUserData["gender"] as? String{
                        self.allUsers.append(User(
                            id: user.data()["id"] as! String,
                            email: user.data()["email"] as! String,
                            name: user.data()["name"] as! String,
                            gender: user.data()["gender"] as! String,
                            age: user.data()["age"] as! String,
                            hometown: user.data()["hometown"] as! String,
                            subject: user.data()["subject"] as! String,
                            introduction: user.data()["introduction"] as! String,
                            studystyle: user.data()["studystyle"] as! String,
                            hobby: user.data()["hobby"] as! String,
                            personality: user.data()["personality"] as! String,
                            work: user.data()["work"] as! String,
                            purpose: user.data()["purpose"] as! String,
                            photoURL: user.data()["photoURL"] as! String
                        ))
                        
                    }
                    
                }
            }
        }
    }
    
    func getCurrentUser() {
        db.collection("Users").whereField("email", isEqualTo: datas.session!.email!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.currentUserData = document.data()
                   
                    self.getAllUsers()
                }
            }
        }
        
        //        self.getAllUsers()
    }
    
    func getFavoriteUsers(){

            db.collection("FavoriteTable").document(self.currentUserData["id"] as! String).collection("FavoriteUser")
    //            .whereField("MyUserId", isEqualTo: self.shareData.currentUserData["id"] as! String)
                .addSnapshotListener { (snap, err) in

                    guard let snapshot = snap else {
                        print("Error fetching snapshots: \(err!)")
                        return
                    }
                    snapshot.documentChanges.forEach { diff in
                        if (diff.type == .added) {
                            self.favoriteUserIds.append(diff.document.data()["FavoriteUserId"] as! String)
                        }
    //                    if (diff.type == .modified) {
    //                        print("Modified city: \(diff.document.data())")
    //                    }
                        if (diff.type == .removed) {
                            for userId in self.favoriteUserIds{
                                if userId == diff.document.data()["FavoriteUserId"] as! String{
                                    if let index = self.favoriteUserIds.firstIndex(of: userId) {
                                        self.favoriteUserIds.remove(at: index)
                                    }
                                }
                            }
                    }
    //            if err != nil{
    //                print(err?.localizedDescription ?? "エラー: getFavoriteUsers1")
    //                return
    //            }
    //            for user in snap!.documents{
    ////              print(user.documentID) documentID = user.IDだ
    //                self.favoriteUserIds.append(user.documentID)
    //            }
             }
        }
        }
    
    
    

    
    
    
}
