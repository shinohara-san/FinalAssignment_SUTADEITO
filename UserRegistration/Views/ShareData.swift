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
    @Published var displayedUser: User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
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
//            self.allUsers.remove(at: 0)

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
    
    func getAllFavoriteUsers(){
        db.collection("FavoriteTable").document(self.currentUserData["id"] as! String).collection("FavoriteUser").getDocuments { (snap, err) in
            if let snap = snap {
                for user1 in snap.documents {
//                    print(user.data()["FavoriteUserId"] as? String ?? "")
                    self.db.collection("Users").whereField("id", isEqualTo: user1.data()["FavoriteUserId"] as? String ?? "").getDocuments { (snap, err) in
                        if let snap = snap {
                            for user in snap.documents {
                                
                                self.favoriteUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as? String ?? ""))

                            }
                            } else {
                            print(err?.localizedDescription ?? "")
                            return
                        }
                    }
                }
            } else { return }
            self.favoriteUsers.remove(at: 0)
        }
    }
    
}
