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
            ScrollView(showsIndicators: false){
                VStack{
                   
                        ForEach(self.shareData.likeUsers){ user in
                            VStack{
                                FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.7).padding(.top)
                                Text(user.name)
                                Text(user.gender)
                                Text(user.age)
                            }
                            .onTapGesture {
                                self.likeUserInfo = user
                                self.likeProfileOn = true
                            }
                        }
                }

                }//vs
            } //sc
            .sheet(isPresented: self.$likeProfileOn) {
                UserProfileView(user: self.likeUserInfo, matchUserProfile: false).environmentObject(self.shareData)
            }
            .navigationBarTitle("いいねしたユーザー", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.shareData.switchFavAndLike = false
                }, label: {
                    Image(systemName: "arrow.counterclockwise").foregroundColor(self.shareData.white)
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
