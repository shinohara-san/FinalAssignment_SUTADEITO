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
    @State var likeUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    var body: some View {
        GeometryReader{ geometry in
        NavigationView{
        ZStack{
            self.shareData.white.edgesIgnoringSafeArea(.all)
            List{
//                VStack{
                   
                        ForEach(self.shareData.likeUsers){ user in
                            VStack{
                            HStack{
                                FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                                .clipShape(Circle()).shadow(radius: 2, x:2, y:2)
                                    .padding(.top, 8).padding(.leading)
                            VStack(alignment: .leading,spacing: 5){
                                
                                Text(user.name).frame(width: geometry.size.width * 0.5, alignment: .leading)
                                Text(user.age).frame(width: geometry.size.width * 0.5, alignment: .leading)
                            }
                        } //hs
//                                Divider().frame(width: geometry.size.width * 0.8)
                }.listRowBackground(self.shareData.white)
                            .onTapGesture {
                                self.likeUserInfo = user
                                self.likeProfileOn = true
                            }
                        }

                }//vs
            .onAppear { UITableView.appearance().separatorStyle = .none }
            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
            } //sc
            .sheet(isPresented: self.$likeProfileOn) {
                UserProfileView(user: self.likeUserInfo, matchUserProfile: false).environmentObject(self.shareData)
            }
            .navigationBarTitle("いいねしたユーザー", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.shareData.switchFavAndLike = false
                }, label: {
                    Image(systemName: "arrow.right.arrow.left").foregroundColor(self.shareData.white)
                })
            )
//            .navigationBarHidden(true)
            .onAppear{
                //                DispatchQueue.global().sync {
                self.shareData.getAllLikeUsers()
                //                }
            }
            .onDisappear{
                self.shareData.likeUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
                //                        self.likeProfileOn = false //favorite viewを去るときにmain viewも元の一覧表示に戻してあげる処理
            }
            
        } //zsat
        }
    }
    } //body
 //view

struct LikeUserView_Previews: PreviewProvider {
    static var previews: some View {
        LikeUserView()
    }
}
