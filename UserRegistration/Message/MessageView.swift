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
                self.shareData.white.edgesIgnoringSafeArea(.all)
                VStack{
                    List{
                    ForEach(self.msgVM.messages){ i in
                        if i.fromUser == self.shareData.currentUserData["id"] as? String ?? "" {
                            MessageRow(message: i.msg, isMyMessage: true)
//                                .frame(width: geometry.size.width * 0.5)
                        } else {
                            MessageRow(message: i.msg, isMyMessage: false)
//                                .frame(width: geometry.size.width * 0.5)
                        }
                    }
                    }//list
                        
                    .onAppear { UITableView.appearance().separatorStyle = .none }
                    .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                    
                    //            }
                    HStack{
                        TextField("メッセージ", text: self.$text).textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                        Button(action: {
                            if self.text.count > 0 {
                                print("送信時マッチID: \(self.msgVM.matchId)")
                                self.msgVM.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String, matchId: self.msgVM.matchId)
                                
                                self.text = ""
                                print("MessageViewでの送信後のmessages: \(self.msgVM.messages)")
                            }
                            
                        }) {
                            Image(systemName: "paperplane.fill").foregroundColor(self.shareData.pink)
                        }.padding(.horizontal)
                    }.padding(.bottom)
                    .sheet(isPresented: self.$isModal) {
                        UserProfileView(user: self.matchUserInfo, matchUserProfile: true).environmentObject(self.shareData)
                    }        }
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

struct PartlyRoundedCornerView: UIViewRepresentable {
    let cornerRadius: CGFloat
    let maskedCorners: CACornerMask

    func makeUIView(context: UIViewRepresentableContext<PartlyRoundedCornerView>) -> UIView {
        // 引数で受け取った値を利用して、一部の角のみを丸くしたViewを作成する
        let uiView = UIView()
        uiView.layer.cornerRadius = cornerRadius
        uiView.layer.maskedCorners = maskedCorners
        uiView.backgroundColor = .white
        return uiView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PartlyRoundedCornerView>) {
    }
}
