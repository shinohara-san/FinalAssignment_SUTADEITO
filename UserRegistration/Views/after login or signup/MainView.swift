//
//  MainView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
//shino@aaa.com
//　1234shino

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


struct MainView: View {
    
    var datas: FirebaseData
//    var userData: FirebaseAuth.User?
    @EnvironmentObject var shareData: ShareData
//    @State var currentUser = [String : Any]()
//    @State var allUsers = [User]()
    
    let db = Firestore.firestore()
    func getCurrentUser() {
        db.collection("Users").whereField("email", isEqualTo: datas.session!.email!).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.shareData.currentUserData = document.data()
//                        print(self.shareData.currentUserData)
//                        self.currentUser = document.data()
//                        print(self.currentUser["subject"] ?? "")
//                        print("ゲットカレントビュー")
                    }
                }
        }

//        self.getAllUsers()
    }
    
//    func getAllUsers(){
//           let dbCollection = Firestore.firestore().collection("Users")
//    //        .whereField("gender", isEqualTo: chosenGender).
//            dbCollection.getDocuments { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for user in querySnapshot!.documents {
//    //                    print(user.data())shareData.currentUserData["email"]
//    //                    User型に直してappend
//                        if user.data()["gender"] as? String != self.shareData.currentUserData["gender"] as? String{
//
//                        self.allUsers.append(User(
//                            id: user.data()["id"] as! String,
//                            email: user.data()["email"] as! String,
//                            name: user.data()["name"] as! String,
//                            gender: user.data()["gender"] as! String,
//                            age: user.data()["age"] as! Int,
//                            hometown: user.data()["hometown"] as! String,
//                            subject: user.data()["subject"] as! String,
//                            introduction: user.data()["introduction"] as! String,
//                            studystyle: user.data()["studystyle"] as! String,
//                            hobby: user.data()["hobby"] as! String,
//                            personality: user.data()["personality"] as! String,
//                            work: user.data()["work"] as! String,
//                            purpose: user.data()["purpose"] as! String,
//                            photoURL: user.data()["photoURL"] as! String
//                            ))
//
//                        } else {
//                            print("\(String(describing: user.data()["name"]!)) has the same gender as the current user does.)")
//    //                        return
//                        }
//
//                    }
//                }
//            }
//        }
    
    
    var body: some View {
    
       TabView {
//        ListView(datas: self.datas, currentUser: self.shareData.currentUserData)
        ListView(datas: self.datas) //environmentに書き換えたい
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                    }
            }.tag(1)
            SearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                    }
            }.tag(2)
        FavoriteView()
            .tabItem {
                VStack {
                    Image(systemName: "star")
                }
        }.tag(3)
        MatchView()
            .tabItem {
                VStack {
                    Image(systemName: "suit.heart")
                }
        }.tag(4)
        SettingView(datas: self.datas)  //environmentに書き換えたい
            .tabItem {
                VStack {
                    Image(systemName: "ellipsis")
                }
        }.tag(5)
        }
       .onAppear{
        
            self.getCurrentUser()
        
//            self.getAllUsers()
//        print("\(self.shareData.currentUserData["name"] ?? "空っぽ") is the current user at MainView")
        print("メインビュー")
//        print(self.userData?.email ?? "メインビュープリント")
//        動いてない？？？
       }
       .navigationBarTitle("")
       .navigationBarHidden(true)
    
    }
    }

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}


//guard let user = Auth.auth().currentUser else {
//    return
//}
