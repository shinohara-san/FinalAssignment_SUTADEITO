//
//  UserWindowView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/20.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

//お気に入りユーザー一覧で使う一つ一つの表示用

import SwiftUI
import FirebaseFirestore

struct UserWindowView: View {
    var userId:String 
    @State var displayedUser: User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    let db = Firestore.firestore()
    func getUserInfo(){
        db.collection("Users").whereField("id", isEqualTo: userId).getDocuments { (snap, err) in
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
                FirebaseImageView(imageURL: self.displayedUser.photoURL)
                HStack{
                    Text(self.displayedUser.name)
                    Text(self.displayedUser.hometown)
                }
            }
        .onAppear{
        self.getUserInfo()
        }
    }
}

//struct UserWindowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserWindowView()
//    }
//}
