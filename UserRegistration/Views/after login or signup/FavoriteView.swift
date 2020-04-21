//
//  FavoriteView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//  一回来てデータなくて戻ったらデータある
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
    func emptyFavoriteUsers(){
        self.favoriteUserIds = [String]()
    }
    
    var body: some View {
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


struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
