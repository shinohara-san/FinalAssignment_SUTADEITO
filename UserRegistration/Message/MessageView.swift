//
//  MessageView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/23.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseFirestore


struct MessageView: View {
    
    
    let matchUserInfo: User
    let matchRoomId: String
    
    @ObservedObject private var msgVM: MessageViewModel
    
    init(_ user: User, _ id:String) {
        self.matchUserInfo = user
        self.matchRoomId = id
        //_　アンダーバーつけるとtypeじゃなくなりエラー消える 
        self._msgVM = ObservedObject(initialValue: MessageViewModel(matchId: matchRoomId))
    }
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var shareData : ShareData
    @State var text = ""
    @State var matchId = ""
    @State var isModal = false
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                self.shareData.pink.edgesIgnoringSafeArea(.all)
                VStack{
                    List{
                        ForEach(self.msgVM.messages){ i in
                            if i.fromUser == self.shareData.currentUserData["id"] as? String ?? "" {
                                MessageRow(message: i.msg, isMyMessage: true).frame(height: 63)//rowの高さが足りないと表示されない

                               
                            } else {
                                MessageRow(message: i.msg, isMyMessage: false).frame(height: 63)

                            }
                            
                        }.listRowBackground(self.shareData.white)
                    }
                    .padding(.bottom, 10)//メッセテキストフィールドの上にいい感じにスペースできた
                    .onAppear { UITableView.appearance().separatorStyle = .none }
                    .onDisappear { UITableView.appearance().separatorStyle = .singleLine }

                    HStack{
                        TextField("メッセージ(44文字まで)", text: self.$text).textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                        Button(action: {
                            if self.text.count > 0 && self.text.count < 44{
//                                print("送信時マッチID: \(self.msgVM.matchId)")
                                self.msgVM.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String, matchId: self.msgVM.matchId)
                                
                                self.text = ""
//                                print("MessageViewでの送信後のmessages: \(self.msgVM.messages)")
                            }
                            
                        }) {
                            Image(systemName: "paperplane.fill").foregroundColor(self.shareData.white)
                        }.padding(.horizontal)
                    }.padding(.bottom)
                        .sheet(isPresented: self.$isModal) {
                            UserProfileView(user: self.matchUserInfo, matchUserProfile: true).environmentObject(self.shareData)
                    }
                    
                }//vstack
     
            }
            .navigationBarTitle("\(self.matchUserInfo.name)", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.turn.up.left").foregroundColor(self.shareData.white)
                }),
                                trailing: Button(action: {
                                    self.isModal = true
                                }, label: {
                                    Image(systemName: "person.fill").foregroundColor(self.shareData.white)
                                })
            )
                .navigationBarBackButtonHidden(true)
            //            .onAppear{
            //                print("MessageViewでのmessages: \(self.msgVM.messages)")
            //        }
            
            
            //        .onDisappear{
            //            self.msgVM.messages = [Message]()
            //        }
            
            
        }// geo
    }
    
    func getMatchId(partner: User){
        Firestore.firestore().collection("MatchTable").document(self.shareData.currentUserData["id"] as? String ?? "").collection("MatchUser").whereField("MatchUserId", isEqualTo: partner.id).getDocuments { (snap, err) in
            if let snap = snap {
                for id in snap.documents{
                    self.msgVM.matchId = id.data()["MatchRoomId"] as? String ?? "nilだよ"
                    print("MatchId＠ゲットマッチID is \(self.msgVM.matchId)")
                    _ = MessageViewModel(matchId: self.msgVM.matchId) //ok
                    print("メッセージビューも\(self.msgVM.messages)")
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
//
//extension View {
//    public func flip() -> some View {
//        return self
//            .rotationEffect(.radians(.pi))
//            .scaleEffect(x: -1, y: 1, anchor: .center)
//    }
//}
//
