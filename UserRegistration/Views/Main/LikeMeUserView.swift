//
//  LikeMeUserView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/05.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct LikeMeUserView: View {
        @EnvironmentObject var shareData: ShareData
        //    @State var favoriteProfileOn = false
        @State var likeUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule: "", place: "")
        @State var isModal = false

        
        var body: some View {
            
            GeometryReader{ geometry in
                NavigationView{
                    ZStack{
                        Color.myWhite.edgesIgnoringSafeArea(.all)
                        List{
                            ForEach(self.shareData.filteredLikeMeUsers, id: \.id){ user in
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
                                    }
                                    if user.id == "" {
                                        Divider().hidden()
                                    } else {
                                        Divider()
                                    }
                            }
                                    .padding(.bottom)
                                .listRowBackground(self.shareData.emptyUser(user: user) ? Color.myWhite : Color.myWhite2)
                                    .onTapGesture {
                                         if user.id == "" {return}
                                        self.likeUserInfo = user
                                        self.isModal = true
                                }
                            }
                            
                        } //list
                            
                            .onAppear { UITableView.appearance().separatorStyle = .none }
                            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                            .sheet(isPresented: self.$isModal) {
                                UserProfileView(user: self.likeUserInfo, matchUserProfile: false).environmentObject(self.shareData)
                        }
                        .navigationBarTitle(Text("あなたと一緒に勉強したいいねユーザー"), displayMode: .inline)
                        .navigationBarItems(trailing:
                            Button(action: {
                                self.shareData.myProfile = true
                            }, label: {
                                Image(systemName: "house.fill").foregroundColor(Color.myWhite2)
                            })
                            )
                            .onAppear{
                                //                DispatchQueue.global().sync {
                                self.shareData.getAllLikeMeUser()
                                //                }
                                
                        }
                        .onDisappear{
//                            self.shareData.filteredLikeMeUsers = [User]()
                        }
                    } //navi
                }
                
            }
        } //body
    } //view



struct LikeMeUserView_Previews: PreviewProvider {
    static var previews: some View {
        LikeMeUserView()
    }
}
