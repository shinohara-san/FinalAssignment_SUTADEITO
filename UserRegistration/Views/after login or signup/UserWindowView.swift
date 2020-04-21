//
//  UserWindowView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/20.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct UserWindowView: View {
    var userId:String
    let db = Firestore.firestore()
    func getUserInfo(){
        db.collection("Users").whereField("id", isEqualTo: userId).getDocuments { (snap, err) in
            print(snap?.documents)
        }
        
    }
    
    var body: some View {
        Text(self.userId)
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
