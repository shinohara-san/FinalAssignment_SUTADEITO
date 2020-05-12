//import SwiftUI
//import FirebaseFirestore
//
//
//struct MessageView: View {
//    
//    let matchUserInfo: User
//    let matchRoomId: String
//    
//    @ObservedObject private var msgVM: MessageViewModel
//    
//    init(_ user: User, _ id:String) {
//        self.matchUserInfo = user
//        self.matchRoomId = id
//        //_　アンダーバーつけるとtypeじゃなくなりエラー消える
//        self._msgVM = ObservedObject(initialValue: MessageViewModel(matchId: matchRoomId))
//    }
//    
//    @Environment(\.presentationMode) var presentation
//    @EnvironmentObject var shareData : ShareData
//    @State var text = ""
//    @State var matchId = ""
//    @State var isModal = false
//    
//    private func talkBubbleTriange(
//        width: CGFloat,
//        height: CGFloat,
//        isIncoming: Bool) -> some View {
//        
//        Path { path in
//            path.move(to: CGPoint(x: isIncoming ? 0 : width, y: height * 0.5))
//            path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: height * 0.7))
//            path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: 0))
//            path.closeSubpath()
//        }
//        .fill(isIncoming ? shareData.yellow : shareData.green)
//        .frame(width: width, height: height)
//        .shadow(radius: 1, x: 2, y: 2)
//.zIndex(10)
//    .clipped()
//    .padding(.trailing, isIncoming ? -1 : 10)
//    .padding(.leading, isIncoming ? 10 : -1)
//    .padding(.bottom, 12)
//}
//
//var dummy = [Message(id: "", msg: "", fromUser: "", toUser: "", date: "", hinichi: "", matchId: "")]
//
////    @State var offset : CGFloat = 0.0
//
//
//var body: some View {
//    GeometryReader{ geometry in
//        
//        ZStack{
//            self.shareData.pink.edgesIgnoringSafeArea(.all)
//            VStack{
//                List{
//                    ForEach(self.msgVM.messages.reversed()){ i in //.reversed()
//                        if i.fromUser == self.shareData.currentUserData["id"] as? String ?? "" {
//                            // MessageRow(message: i.msg, isMyMessage: true)
//                            ///MessegeRowをかますと高さが一行分になってしまう
//                            VStack(spacing: 0){
//                                
//                                HStack{
//                                    Spacer()
//                                    HStack{
//                                        Text(i.msg)
//                                            .padding(13)
//                                            .background(RoundedCorners(color: self.shareData.green, tl: 20, tr: 20, bl: 20, br: 2))
//                                            .foregroundColor(self.shareData.black)
//                                        
//                                    }
//                                }
//                                HStack{
//Spacer()
//                    Text(i.date).font(.footnote).foregroundColor(self.shareData.black)
//                }
//                
//            }
//        } else {
//            VStack(spacing: 0){
//            
//            HStack{
//                Text(i.msg)
//                    .padding(13)
//                    .background(RoundedCorners(color: self.shareData.yellow, tl: 20, tr: 20, bl: 2, br: 20))
//                    .foregroundColor(self.shareData.black)
//                
//                Spacer()
//            }
//            HStack{
//                Text(i.date).font(.footnote).foregroundColor(self.shareData.black)
//                Spacer()
//            }
//        }
//        }
//        ///メッセージがいっぱいになったらrotationEffectかける
//    }
//    .rotationEffect(.radians(.pi), anchor: .center)
//    .listRowBackground(self.shareData.white)
//}
//    .rotationEffect(.radians(.pi), anchor: .center)
//    .padding(.bottom, 10)//メッセテキストフィールドの上にいい感じにスペースできた
//    .onAppear {
//        UITableView.appearance().separatorStyle = .none
//}
//.onDisappear { UITableView.appearance().separatorStyle = .singleLine }
// HStack{
//                        TextField("メッセージ", text: self.$text).textFieldStyle(CustomTextFieldStyle(geometry: geometry))
//                        Button(action: {
//                            if self.text.count > 0{
//                                self.msgVM.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String, matchId: self.msgVM.matchId)
////                                print(self.msgVM.messages)
//                                self.text = ""
//                                
//                            }
//                            
//                        }) {
//                            Image(systemName: "paperplane.fill").foregroundColor(self.shareData.white)
//                        }.padding(.horizontal)
//                    }.padding(.bottom)
//                        .sheet(isPresented: self.$isModal) {
//                            UserProfileView(user: self.matchUserInfo, matchUserProfile: true).environmentObject(self.shareData)
//                    }
//                    
//                }//vstack
//                    .navigationBarTitle("\(self.matchUserInfo.name)", displayMode: .inline)
//                    .navigationBarItems(leading:
//                        Button(action: {
//                            self.presentation.wrappedValue.dismiss()
//                        }, label: {
//                            Image(systemName: "arrow.turn.up.left").foregroundColor(self.shareData.white)
//                        }),
//                                        trailing: Button(action: {
//                                            self.isModal = true
//                                        }, label: {
//                                            Image(systemName: "person.fill").foregroundColor(self.shareData.white)
//                                        })
//                )
//                    .navigationBarBackButtonHidden(true)
//                
//                
//            }
//        }// geo
//    }
