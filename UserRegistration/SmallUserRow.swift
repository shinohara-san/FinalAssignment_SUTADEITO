//
//  SmallUserRow.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/04.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

//struct SmallUserRow: View {
//    @EnvironmentObject var shareData: ShareData
//    let user : User
//    let geometry : GeometryProxy
//    
//    var body: some View {
//        HStack{
//            FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
//                .clipShape(Circle()).shadow(radius: 2, x:2, y:2)
//                .padding(.top, 8).padding(.leading)
//            VStack(alignment: .leading,spacing: 5){
//                
//                Text(user.name).frame(width: geometry.size.width * 0.5, alignment: .leading)
//                Text(user.age).frame(width: geometry.size.width * 0.5, alignment: .leading)
//            }
//        } //hs
//            //                                Divider().frame(width: geometry.size.width * 0.8)
//            .listRowBackground(self.shareData.white)
//    }
//}
//
////struct SmallUserRow_Previews: PreviewProvider {
////    static var previews: some View {
////        SmallUserRow()
////    }
////}
