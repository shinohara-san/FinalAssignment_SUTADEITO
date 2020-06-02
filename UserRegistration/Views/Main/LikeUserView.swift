//
//  LikeUserView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct LikeUserView: View {
    @EnvironmentObject var shareData: ShareData
    @State var likeListOn = false
    @State var likeProfileOn = false
    @State var likeUserInfo = EmptyUser.forLayout
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    Color.myWhite.edgesIgnoringSafeArea(.all)
                    List{
                        ForEach(self.shareData.filteredLikeUsers, id: \.id){ user in
                            VStack{
                                HStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                                        .clipShape(Circle()).shadow(radius: 2, x:2, y:5)
                                        .padding(.top, 8).padding(.leading)
                                    VStack(alignment: .leading,spacing: 5){
                                        HStack{
                                            
                                            if self.shareData.goodUser(user: user){
                                                    Image(systemName: "hand.thumbsup.fill").foregroundColor(.yellow)
                                                }

                                            Text(user.name)
                                        }
                                        
                                        Text(user.age)
                                        
                                    }.foregroundColor(Color.myBlack).frame(width: geometry.size.width * 0.5, alignment: .leading)
                                } //hs
                                if user.id == "" {
                                    Divider().hidden()
                                } else {
                                    Divider()
                                }
                            }
                            .listRowBackground(self.shareData.emptyUser(user: user) ? Color.myWhite : Color.myWhite2)
                            .onTapGesture {
                                if user.id == "" {return}
                                self.likeUserInfo = user
                                self.likeProfileOn = true
                            }
                        }
                        
                    }
                    .onAppear { UITableView.appearance().separatorStyle = .none }
                    .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                } //sc
                    .sheet(isPresented: self.$likeProfileOn) {
                        UserProfileView(user: self.likeUserInfo, matchUserProfile: false).environmentObject(self.shareData)
                }
                .navigationBarTitle("一緒に勉強したいいねしたユーザー", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.shareData.switchFavAndLike = false
                    }, label: {
                        Image(systemName: "arrow.right.arrow.left").foregroundColor(Color.myWhite)
                    }), trailing:
                    Button(action: {
                        self.shareData.myProfile = true
                    }, label: {
                        Image(systemName: "house.fill").foregroundColor(Color.myWhite)
                    })
                )
                    //            .navigationBarHidden(true)
                    .onAppear{
                        //                DispatchQueue.global().sync {
                        self.shareData.getAllLikeUsers()
                        //                }
                }
                
                
            } //zsat
        }
    }
} //body
//view

//struct LikeUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikeUserView()
//    }
//}
