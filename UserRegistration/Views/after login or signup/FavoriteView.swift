//
//  FavoriteView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.

import SwiftUI
import FirebaseFirestore

struct FavoriteView: View {
    @State var displayedUser: User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    @EnvironmentObject var shareData: ShareData
    let db = Firestore.firestore()
    func getUserInfo(favoriteUserId: String){
        db.collection("Users").whereField("id", isEqualTo: favoriteUserId).getDocuments { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            } else {
                for user in snap!.documents{
                    self.displayedUser = User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String)
                }
            }
        }
        
    }
    
    var body: some View {
            VStack{
                Text("favorite view")
            }

        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear{
            self.shareData.getFavoriteUsers()
        }
        .onDisappear{
            self.shareData.favoriteUserIds = []
        }
    }
}


struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
