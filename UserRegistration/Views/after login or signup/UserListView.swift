//
//  UserListView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var shareData: ShareData
    @State var userProfileOn = false
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    
    private func chatBubbleTriange(
        width: CGFloat,
        height: CGFloat,
        isIncoming: Bool) -> some View {
        
        Path { path in
            path.move(to: CGPoint(x: 0, y: height * 0.5))
            path.addLine(to: CGPoint(x: width, y: height * 0.7))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.closeSubpath()
        }
        .fill(shareData.brown)
        .frame(width: width, height: height)
        .shadow(radius: 2, x: 2, y: 2)
        .zIndex(10)
        .clipped()
        .padding(.trailing, -1)
        .padding(.leading, 10)
        .padding(.bottom, 12)
    }
    
    var body: some View {
        
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    self.shareData.white.edgesIgnoringSafeArea(.all)
                    //                    ScrollView(showsIndicators: false){
                    List{
                        ForEach(self.shareData.allUsers){ user in
                            //                            VStack{
                            HStack(spacing: 0){
                                //                                        Spacer()
                                VStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2, alignment: .leading)
                                        .clipShape(Circle()).shadow(radius: 2, x:2, y:2)
                                        .padding(.top, 8)
                                    HStack(spacing: 5){
                                        
                                        Text(user.age).frame(width: geometry.size.width * 0.2, alignment: .trailing)
                                        Text(user.hometown).frame(width: geometry.size.width * 0.3, alignment: .leading)
                                    }.frame(width: geometry.size.width * 0.5)
                                }
                                HStack(spacing: 0){
                                    self.chatBubbleTriange(width: geometry.size.width * 0.08, height: geometry.size.height * 0.05, isIncoming: true)
                                    Text(user.subject).padding().frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2, alignment: .leading).background(self.shareData.brown).foregroundColor(self.shareData.white).cornerRadius(10).shadow(radius: 2, x: 2, y: 2)
                                }
                                Spacer()
                                
                            }
                                .onTapGesture {
                                    self.userInfo = user
                                    self.userProfileOn = true
                            }
                        } //foreach
                            .listRowBackground(self.shareData.white).id(UUID())
                    }
//                        .id(UUID())
                    .onAppear { UITableView.appearance().separatorStyle = .none }
                        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                        .onAppear{
                            //                                 DispatchQueue.global().sync {
                            self.shareData.getCurrentUser()//                            print("ログインユーザー: \(self.shareData.currentUserData["name"] ?? "ログインユーザ情報なし")")
//                            print("ユーザー一覧: \(self.shareData.allUsers)")
                    }
                }
                    //                    .id(UUID())
                    .navigationBarTitle("ユーザー", displayMode: .inline)
                    .sheet(isPresented: self.$userProfileOn) {
                        UserProfileView(user: self.userInfo, matchUserProfile: false).environmentObject(self.shareData)
                } //z
            }//navi
        }//geo
    }//body
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
