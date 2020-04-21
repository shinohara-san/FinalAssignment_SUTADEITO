//
//  FavoriteView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.

import SwiftUI
import FirebaseFirestore

struct FavoriteView: View {
    
    let db = Firestore.firestore()
    @EnvironmentObject var shareData: ShareData
    
    @State var favoriteUserIds = [String]()
    
    func getFavoriteUsers(){
        
        db.collection("FavoriteTable").document(self.shareData.currentUserData["id"] as! String).collection("FavoriteUser")
//            .whereField("MyUserId", isEqualTo: self.shareData.currentUserData["id"] as! String)
            .addSnapshotListener { (snap, err) in
                
                guard let snapshot = snap else {
                    print("Error fetching snapshots: \(err!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
//                        print("New favorite:  \(diff.document.data()["FavoriteUserId"] ?? "")")
                        self.favoriteUserIds.append(diff.document.data()["FavoriteUserId"] as! String)
                    }
//                    if (diff.type == .modified) {
//                        print("Modified city: \(diff.document.data())")
//                    }
                    if (diff.type == .removed) {
//                        print("Removed favorite: \(diff.document.data()["FavoriteUserId"] ?? "")")
                        for userId in self.favoriteUserIds{
                            if userId == diff.document.data()["FavoriteUserId"] as! String{
                                if let index = self.favoriteUserIds.firstIndex(of: userId) {
                                    self.favoriteUserIds.remove(at: index)
                                }
                            }
                        }
                }

         }
    }
    }
    
    var body: some View {
//        ここにscroll持ってこれたら
        VStack{
            ForEach(self.favoriteUserIds, id: \.self) { favoriteUserId in
                UserWindowView(userId: favoriteUserId)
//                Text(favoriteUserId)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear{
            self.getFavoriteUsers()
                
        }
//        .onDisappear{
//            self.emptyFavoriteUsers()
//        }
    }
}
//
//struct FavoriteView: View {
//    @EnvironmentObject var shareData: ShareData
//
//    let db = Firestore.firestore()
//    func getUserInfo(favoriteUserId: String){
//        db.collection("Users").whereField("id", isEqualTo: favoriteUserId).getDocuments { (snap, err) in
//            if let err = err {
//                print(err.localizedDescription)
//                return
//            } else {
//                for user in snap!.documents{
//                    self.shareData.favoriteUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String))
//                }
//            }
//        }
//
//    }
//
//    func getIds(){
//        db.collection("FavoriteTable").document(self.shareData.currentUserData["id"] as! String).collection("FavoriteUser").getDocuments { (snap, err) in
//            for i in snap!.documents{
//                self.shareData.favoriteUserIds.append(i.data()["FavoriteUserId"] as! String)
////                print(self.shareData.favoriteUserIds)
//            }
//        }
//    }
//
//
////        for favoriteUserId in self.shareData.favoriteUserIds{
//////            self.shareData.favoriteUsers = [User]()
////            self.getUserInfo(favoriteUserId: favoriteUserId)
////        }
////
//
//
//
//    var body: some View {
//            VStack{
//                Text("Favorite view")
////                ForEach(self.shareData.favoriteUserIds){ id in
////                    Text(self.shareData.favoriteUserIds[id])
////                }
////                ForEach(self.displayedUser)
//            }
//
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .onAppear{()
//            self.getIds()
//            self.shareData.getFavoriteUsers()
//            print(self.shareData.favoriteUserIds)
////            print(self.shareData.favoriteUsers)
//        }
//        .onDisappear{
//            self.shareData.favoriteUserIds = []
//        }
//    }
//}
//
//
//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView()
//    }
//}
