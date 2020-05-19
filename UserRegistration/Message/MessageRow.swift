//
//  MessageRow.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/23.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
import SwiftUI

struct MessageRow: View {
    @EnvironmentObject var shareData: ShareData
    var message = ""
    var isMyMessage = false

    var body: some View {
        GeometryReader{ geometry in
        HStack {
            if self.isMyMessage {
                Spacer()
//                VStack{
                HStack(spacing : 0){
                    Text(self.message)
//                        .lineLimit(nil)
                        
                    .padding(10)
                        .background(Color.myGreen)
                    .cornerRadius(6)
                        .foregroundColor(Color.myBlack)
                    .shadow(radius: 1, x: 2, y: 2)
                    .layoutPriority(1)
                    self.talkBubbleTriange(width: geometry.size.width * 0.05, height: geometry.size.height * 0.4, isIncoming: false)
                    }
//                }
                
            } else {
//                VStack{
                    HStack(spacing : 0){
                        self.talkBubbleTriange(width: geometry.size.width * 0.05, height: geometry.size.height * 0.4, isIncoming: true)
                        Text(self.message)
                            //.lineLimit(nil)
//                            .fixedSize(horizontal: false, vertical: true)
                    .padding(10)
                    .background(Color.myYellow)
                    .cornerRadius(6)
                            .foregroundColor(Color.myBlack)
                    .shadow(radius: 1, x: 2, y: 2)
                    }
//                }

                Spacer()
            }
        } //hstack
            
        } //geo
    }
    
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
        .fill(isIncoming ? Color.myYellow : Color.myGreen)
        .frame(width: width, height: height)
        .shadow(radius: 1, x: 2, y: 2)
        .zIndex(10)
        .clipped()
        .padding(.trailing, isIncoming ? -1 : 10)
        .padding(.leading, isIncoming ? 10 : -1)
        .padding(.bottom, 12)
    }
    
}

struct messageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(message: "Hoge", isMyMessage: false)
    }
}
