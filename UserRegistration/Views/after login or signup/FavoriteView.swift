////
////  FavoriteView.swift
////  UserRegistration
////
////  Created by Yuki Shinohara on 2020/04/17.
////  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
//import SwiftUI
//import FirebaseFirestore
//
//struct FavoriteView: View {
//
////    let db = Firestore.firestore()
//    @EnvironmentObject var shareData: ShareData
//
////    @State var favoriteUserIds = [String]()
//
//    @State var favoriteProfileOn = false
//
//
//    var body: some View {
//
//                VStack{
//
//                    ForEach(self.shareData.favoriteUsers, id: \.self){ user in
//                        Text(user.name)
//                    }
//
//            }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .onAppear{
//            self.shareData.favoriteUserIds = [String]()
////            self.shareData.getFavoriteUsers()
//           
//        }
////        .onDisappear{
//////            self.shareData.favoriteUserIds = [String]()
////        }
//    }
//}
