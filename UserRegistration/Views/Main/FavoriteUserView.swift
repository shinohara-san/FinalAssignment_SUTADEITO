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
    @State var favoriteUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule: "", place: "")
    @State var isModal = false
    var goodUser:Bool{
        return favoriteUserInfo.schedule == "日中" && favoriteUserInfo.place == "カフェ" && favoriteUserInfo.schedule == "日中" && favoriteUserInfo.studystyle != "勉強はせずにお話をしてみたい" && favoriteUserInfo.studystyle != "その他"
    }
    func emptyUser(user: User)->Bool{
        return user.id == ""
    }
    
    var body: some View {
        
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    self.shareData.white.edgesIgnoringSafeArea(.all)
                    List{
                        ForEach(self.shareData.filteredFavoriteUsers, id: \.id){ user in
                            VStack{
                                HStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                                        .clipShape(Circle()).shadow(radius: 2, x:2, y:5)
                                        .padding(.top, 8).padding(.leading).animation(.spring())
                                    VStack(alignment: .leading,spacing: 5){
                                        
                                        HStack{
                                         if self.goodUser{
                                             Image(systemName: "hand.thumbsup.fill").foregroundColor(.yellow)
                                         }
                                        Text(user.name).frame(width: geometry.size.width * 0.5, alignment: .leading)
                                         }
                                         Text(user.age).frame(width: geometry.size.width * 0.5, alignment: .leading)
                                        
                                    }
                                    
                                }
                                if user.id == "" {
                                    Divider().hidden()
                                } else {
                                    Divider()
                                }
                            }
                            .listRowBackground(self.emptyUser(user: user) ? self.shareData.white : self.shareData.white2)
                                .onTapGesture {
                                    if user.id == "" {return}
                                    self.favoriteUserInfo = user
                                    self.isModal = true
                            }
                        }
                        
                    } //list
                        
                        .onAppear { UITableView.appearance().separatorStyle = .none }
                        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                        .sheet(isPresented: self.$isModal) {
                            UserProfileView(user: self.favoriteUserInfo, matchUserProfile: false).environmentObject(self.shareData)
                    }
                    .navigationBarTitle(Text("お気に入りユーザー"), displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            self.shareData.switchFavAndLike = true
                        }, label: {
                            Image(systemName: "arrow.right.arrow.left").foregroundColor(self.shareData.white)
                        }), trailing:
                        Button(action: {
                            self.shareData.myProfile = true
                        }, label: {
                            Image(systemName: "house.fill").foregroundColor(self.shareData.white)
                        })
                        )
                        .onAppear{
                            //                DispatchQueue.global().sync {
                            self.shareData.getAllFavoriteUsers()
                            //                }
                            
                    }

                } //navi
            }
            
        }
    } //body
} //view

//struct FavoriteUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteUserView()
//    }
//}
