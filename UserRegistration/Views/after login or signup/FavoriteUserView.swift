//
//  FavoriteUserView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct FavoriteUserView: View {
    @EnvironmentObject var shareData: ShareData
//    @State var favoriteProfileOn = false
    @State var favoriteUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    @State var isModal = false
    
    var body: some View {
        
        GeometryReader{ geometry in
        NavigationView{
            ZStack{
            self.shareData.white.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false){
                
                ForEach(self.shareData.favoriteUsers){ user in
                    VStack{
                        FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.8).padding(.top)
                        Text(user.name)
                        Text(user.gender)
                        Text(user.age)
                    }
                        .onTapGesture {
                            self.favoriteUserInfo = user
                            self.isModal = true
                    }
                }
                .sheet(isPresented: self.$isModal) {
                    UserProfileView(user: self.favoriteUserInfo, matchUserProfile: false).environmentObject(self.shareData)
                }
                .onAppear{
                    //                DispatchQueue.global().sync {
                    self.shareData.getAllFavoriteUsers()
                    //                }
                }
                .onDisappear{
                    self.shareData.favoriteUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
                    //
            //                    ZStack{
        //                        self.shareData.white.edgesIgnoringSafeArea(.all)                      self.userProfileOn = false //favorite viewを去るときにmain viewも元の一覧表示に戻してあげる処理
                }
                
            } //scroll
                .navigationBarTitle(Text("お気に入りユーザー"), displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.shareData.switchFavAndLike = true
                        print(self.shareData.switchFavAndLike)
                    }, label: {
                        Image(systemName: "arrow.counterclockwise").foregroundColor(self.shareData.white)
                    })
                )
            } //navi
            }
        }
    } //body
} //view

struct FavoriteUserView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteUserView()
    }
}
