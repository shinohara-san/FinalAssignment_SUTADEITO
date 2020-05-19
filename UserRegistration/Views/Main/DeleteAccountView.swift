//
//  DeleteAccountView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/08.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct DeleteAccountView: View {
    @EnvironmentObject var shareData: ShareData
    var datas: FirebaseData
    @Environment(\.presentationMode) var presentation
    
    @State var isChecked:Bool = false
    
    init(_ datas:FirebaseData){
        self.datas = datas
    }
    var body: some View {
        GeometryReader{ geometry in
            ZStack{ Color.myWhite.edgesIgnoringSafeArea(.all)
                VStack{
                    Text("一度退会処理をすると、あなたのユーザー情報、すべてのユーザーとのやり取りなどのデータが消えてしまいます。また、その復旧はできません。").frame(width: geometry.size.width * 0.8).padding(.bottom)
                    Button(action: {
                        self.isChecked.toggle()
                    }) {
                        HStack{
                            Image(systemName: self.isChecked ? "checkmark.square": "square")
                            Text("了承しました。").foregroundColor(.black)
                        }
                    }.padding(.bottom)
                    
                    Button(action: {
                        if self.isChecked{
//                            print("退会処理")
                            self.shareData.deleteAccount() //Auth
                            self.shareData.deleteUserData() //Firestore
                            self.shareData.deleteUserPicture() //storage
                            self.datas.logOut() //追記0508
                            self.presentation.wrappedValue.dismiss()
                            //                    self.shareData.currentUserData = [String : Any]()
                            //                    self.datas.session = nil
                            self.shareData.filteredAllUsers = [User]()
                            self.shareData.filteredMatchUserArray = [User]()
                        }
                        
                    }, label: {
                        Text("退会する").padding().frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.07).foregroundColor(Color.myWhite).background(self.isChecked ? Color.myPink : Color.gray).cornerRadius(10).shadow(radius: 2, x:2, y:2)
                    }).padding(.bottom)
                    Button("戻る"){
                        self.presentation.wrappedValue.dismiss()
                    }.foregroundColor(.black)
                }
            }
        }
    }
}
//
//struct DeleteAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteAccountView()
//    }
//}
