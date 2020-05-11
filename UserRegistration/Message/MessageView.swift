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
    
    private func talkBubbleTriange(
        width: CGFloat,
        height: CGFloat,
        isIncoming: Bool) -> some View {
        
        Path { path in
            path.move(to: CGPoint(x: isIncoming ? 0 : width, y: height * 0.5))
            path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: height * 0.7))
            path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: 0))
            path.closeSubpath()
        }
        .fill(isIncoming ? shareData.yellow : shareData.green)
        .frame(width: width, height: height)
        .shadow(radius: 1, x: 2, y: 2)
        .zIndex(10)
        .clipped()
        .padding(.trailing, isIncoming ? -1 : 10)
        .padding(.leading, isIncoming ? 10 : -1)
        .padding(.bottom, 12)
    }
    
//    @State var offset : CGFloat = 0.0
    
    
    var body: some View {
        GeometryReader{ geometry in
            
            ZStack{
                self.shareData.pink.edgesIgnoringSafeArea(.all)
                VStack{
                    List{
                        ForEach(self.msgVM.messages.reversed()){ i in //.reversed()
                            if i.fromUser == self.shareData.currentUserData["id"] as? String ?? "" {
                                //                                MessageRow(message: i.msg, isMyMessage: true)
                                ///MessegeRowをかますと高さが一行分になってしまう
                                HStack{
                                    Spacer()
                                    HStack(spacing: 0){
                                        Text(i.msg)
                                            .padding(13)
                                            .background(RoundedCorners(color: self.shareData.green, tl: 20, tr: 20, bl: 20, br: 2))
                                            .foregroundColor(self.shareData.black)
                                        
                                    }
                                }
                                
                                
                                
                            } else {
                                HStack{
                                    
                                    HStack(spacing: 0){
                                        Text(i.msg)
                                            .padding(13)
                                            .background(RoundedCorners(color: self.shareData.yellow, tl: 20, tr: 20, bl: 2, br: 20))
                                            .foregroundColor(self.shareData.black)
                                    }
                                    Spacer()
                                }
                                
                            }
                            ///メッセージがいっぱいになったらrotationEffectかける
                        }
                        .rotationEffect(.radians(.pi), anchor: .center)
                        .listRowBackground(self.shareData.white)
//
                    }
//                        .offset(y: geometry.size.height * 0.35)
//                    .frame(height: geometry.size.height * 1)
                    .rotationEffect(.radians(.pi), anchor: .center)
                        .padding(.bottom, 10)//メッセテキストフィールドの上にいい感じにスペースできた
                        .onAppear {
                            UITableView.appearance().separatorStyle = .none
//                            self.msgVM.reverse()
                    }
                        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                    
                    HStack{
                        TextField("メッセージ", text: self.$text).textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                        Button(action: {
                            if self.text.count > 0{
                                self.msgVM.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String, matchId: self.msgVM.matchId)
//                                self.msgVM.reverse()
                                self.text = ""
                         
                            }
                            
                        }) {
                            Image(systemName: "paperplane.fill").foregroundColor(self.shareData.white)
                        }.padding(.horizontal)
                    }.padding(.bottom)
                        .sheet(isPresented: self.$isModal) {
                            UserProfileView(user: self.matchUserInfo, matchUserProfile: true).environmentObject(self.shareData)
                    }
                    
                }//vstack
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
                
                
            }
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

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
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
