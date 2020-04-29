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
import FirebaseAuth

//let shareData = ShareData()

class ShareData:ObservableObject{
//    let msgVM = MessageViewModel(matchId: "")
    let db = Firestore.firestore()
    let datas = firebaseData
    
    @Published var currentUserData = [String : Any]()
    
    //ScrollViewには最初に配列に初期値を設定する必要あり
    
    @Published var allUsers : [User] = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
    
    @Published var displayedUser: User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
//    @Published var matchUserInfo: User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    //    @Published var favoriteUserIds = [String]()
    
    @Published var favoriteUsers: [User] = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
    
    @Published var likeUsers: [User] = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
    
    @Published var searchedUsers: [User] = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
    
    @Published var MatchUsers: [User] = [User]()
    
    @Published var imageURL = ""
    
    var matchUserData: User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    //    var index = 0
    var matchUserId = [String]()
    
    
    let hometowns = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
                     "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
                     "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
                     "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
                     "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
                     "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
                     "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    let jobs = ["会社員", "教師", "医者", "公務員","フリーター", "学生", "その他"]
    let personalities = ["おっとり", "社交的", "元気", "物静か", "その他"]
    let purposes  = ["勉強", "出会い", "婚活", "その他"]
    
    @Published var editOn = false
    
    @Published var matchUserArray = [User]()
    
    
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
    
    func getCurrentUser() {
        db.collection("Users").whereField("email", isEqualTo: datas.session!.email!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.currentUserData = document.data()
                    //                    print(self.currentUserData)
                    
                    self.getAllUsers()
                    
                    //                                        self.filterUsers() //ユーザー情報とれる
                    //                                        self.getAllMatchUser()
                    //                                        print("getAllMatchUser: \(self.matchUserArray)")
                    
                }
            }
        }
        
        //        self.getAllUsers()
    }
    func filtering(){
        for user in self.allUsers{
            for match in self.MatchUsers{
                if user == match {
                    self.allUsers = self.allUsers.filter{ !self.MatchUsers.contains($0)}
                    //                    print("フィルター後: \(self.allUsers)")
                }
            }
        }
    }
    
    
    func getAllUsers(){
        self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除
        //        self.filterUsers()
        //        self.filtering()
        self.db.collection("Users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            //            self.filtering()
            if let snap = querySnapshot {
                for user in snap.documents {
                    //                    for matchId in self.matchUserId {
                    //                    self.filtering()
                    if user.data()["gender"] as? String != self.currentUserData["gender"] as? String
                        //                    if self.matchUserId.count > 0 {
                        //                       if user.data()["id"] as? String != matchId
                        //                    }
                        
                    {
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
                        //                        }
                        //                    }
                        //                        self.filtering()
                    }
                    
                    //matchtableLoopここまで
                    
                    
                    //                    self.filtering()
                }
            }
            //            self.allUsers.remove(at: 0)
            //            self.filtering()
        }
        //        self.filtering()
        self.db.collection("MatchTable")
            .document(self.currentUserData["id"] as! String)
            .collection("MatchUser").getDocuments { (snap, err) in
                if let snap = snap {
                    for id in snap.documents {
                        self.db.collection("Users").whereField("id", isEqualTo: id.data()["MatchUserId"] as! String).getDocuments { (snap, err) in
                            if let snap = snap {
                                for user in snap.documents {
                                    self.MatchUsers.append(User(
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
                                    //                                    print(self.MatchUsers)
                                    self.filtering()
                                }
                                //                                self.filtering()
                            }
                            //                            self.filtering()
                        }
                        //                        self.filtering()
                    }
                    //                    self.filtering()
                }
                //                self.filtering()
        }
        //        self.filtering()
    } //getAllUsers()
    
    
    func getAllFavoriteUsers(){
        db.collection("FavoriteTable")
            .document(self.currentUserData["id"] as? String ?? "")
            .collection("FavoriteUser")
            .getDocuments { (snap, err) in
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
                
                if let snap = snap {
                    for user1 in snap.documents {
                        //                    print(user.data()["FavoriteUserId"] as? String ?? "")
                        self.db.collection("Users")
                            .whereField("id", isEqualTo: user1.data()["FavoriteUserId"] as? String ?? "")
                            .getDocuments { (snap, err) in
                                if let snap = snap {
                                    for user in snap.documents {
                                        //                                if user.data()["id"] as! String がMatchUserIdになかったら
                                        //                                if
                                        //                                self.db.collection("MatchTable").document(self.currentUserData["id"] as! String).collection("MatchUser").whereField("MatchUserId", isLessThan: user.data()["id"] as! String).whereField("MatchUserId", isGreaterThan: user.data()["id"] as! String).getDocuments { (snap, err) in
                                        //                                    if let snap = snap {
                                        //                                       for user in snap.documents{
                                        //                                            print(user.data()["name"] as! String)
                                        self.favoriteUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as? String ?? ""))
                                        
                                        //                                            }
                                        //                                       }
                                        //                                    }
                                        
                                        
                                    }
                                    
                                    
                                } //snap = snap
                                
                        } // getDocuments
                    }
                }
                self.favoriteUsers.remove(at: 0)
        }
    }
    
    func getAllLikeUsers(){
        db.collection("LikeTable")
            .whereField("MyUserId", isEqualTo: self.currentUserData["id"] as? String ?? "")
            .getDocuments { (snap, err) in
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
                
                if let snap = snap {
                    for user1 in snap.documents {
                        //                    print(user.data()["FavoriteUserId"] as? String ?? "")
                        self.db.collection("Users")
                            .whereField("id", isEqualTo: user1.data()["LikeUserId"] as? String ?? "")
                            .getDocuments { (snap, err) in
                                if let snap = snap {
                                    for user in snap.documents {
                                        
                                        self.likeUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as? String ?? ""))
                                        
                                    }
                                } else {
                                    print(err?.localizedDescription ?? "")
                                    return
                                }
                        }
                    }
                } else { return }
                self.likeUsers.remove(at: 0)
        }
    }
    
    func getAllMatchUser(){
        db.collection("MatchTable")
            .document(self.currentUserData["id"] as? String ?? "")
            .collection("MatchUser")
            .getDocuments { (snap, err) in
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
                if let snap = snap{
                    for matchData in snap.documents{
                        //                    print(matchData.data()["MatchUserId"] as? String ?? "")
                        self.db.collection("Users")
                            .whereField("id", isEqualTo: matchData.data()["MatchUserId"] as? String ?? "")
                            .getDocuments { (snap, err) in
                                if err != nil{
                                    return
                                }
                                if let snap = snap{
                                    for user in snap.documents{
                                        //                                print(user.data()["name"] as! String)
                                        self.matchUserArray.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String))
                                    }
                                }
                        }
                        
                    }
                }
                
        }
    }
    
    //  Auth
    func deleteAccount(){
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                print("退会エラー")
                print(error)
                return
            } else {
                // Account deleted.
                print("Auth削除！")
                self.deleteUserData()
                self.deleteUserPicture()
                
                ///マッチテーブルどうなる
            }
        }
    }
    // Firestore
    func deleteUserData(){
        dbCollection
            .whereField("id", isEqualTo: self.currentUserData["id"] ?? "")
            .getDocuments { (snap, err) in
                if err != nil {
                    return
                }
                if let snap = snap {
                    for user in snap.documents {
                        //                        print(user.data()["name"] ?? "")
                        user.reference.delete()
                        print("firestore削除！")
                    }
                }
        }
    }
    //storage
    func deleteUserPicture(){
        //        print(self.currentUserData["email"] ?? "")
        let storageRef = Storage.storage().reference()
        
        // Delete the file
        storageRef
            .child("images/pictureOf_\(self.currentUserData["email"] ?? "")")
            .delete { error in
                if error != nil {
                    // Uh-oh, an error occurred!
                    print(error?.localizedDescription ?? "エラーがdeleteUserPictuireで発生なう")
                    return
                } else {
                    // File deleted successfully
                    print("storage削除！")
                }
        }
    }
    
    
    
    func saveEditInfo(name: String, subject: String, hometown: String, hobby: String, introduction: String, personality: String, studystyle:String, work:String,purpose:String){
        db.collection("Users")
            .whereField("id", isEqualTo: self.currentUserData["id"] ?? "")
            .getDocuments { (snap, err) in
                if let err = err {
                    // Some error occured
                    print(err.localizedDescription)
                    return
                } else if snap!.documents.count != 1 {
                    // Perhaps this is an error for you?
                    print(err?.localizedDescription ?? "")
                    return
                } else {
                    let document = snap!.documents.first
                    document?.reference.updateData([
                        "name": name,
                        "subject": subject,
                        "hometown": hometown,
                        "hobby" : hobby,
                        "introduction" : introduction,
                        "personality" : personality,
                        "studystyle" : studystyle,
                        "work" : work,
                        "purpose" : purpose
                        
                    ])
                    print("編集しました。")
                }
        }
        
    }
    
    
    
    

    
    @Published var matchUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    func searchUser(key: String, value: String){
        
        self.searchedUsers = [User]()
        db.collection("Users").whereField(key, isEqualTo: value).getDocuments { (snap, err) in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            
            if let snap = snap {
                for user in snap.documents{
                    let ref = user.data()
                    if ref["gender"] as? String != self.currentUserData["gender"] as? String{
                        self.searchedUsers.append(User(id: ref["id"] as! String, email: ref["email"] as! String, name: ref["name"] as! String, gender: ref["gender"] as! String, age: ref["age"] as! String, hometown: ref["hometown"] as! String, subject: ref["subject"] as! String, introduction: ref["introduction"] as! String, studystyle: ref["studystyle"] as! String, hobby: ref["hobby"] as! String, personality: ref["personality"] as! String, work: ref["work"] as! String, purpose: ref["purpose"] as! String, photoURL: ref["photoURL"] as! String))
                        
                        for user in self.searchedUsers {
                            for matchUser in self.MatchUsers {
                                if user == matchUser{
                                    self.searchedUsers = self.searchedUsers.filter{ !self.MatchUsers.contains($0)}
                                }
                            }
                        } //マッチしてるユーザをフィルターにかける
                    } //同性を外す条件分岐とじ
                }
            }
        }
        
    }
    
    @Published var messages = [Message]()
//    @Published var matchId = ""
 
   

}//func



