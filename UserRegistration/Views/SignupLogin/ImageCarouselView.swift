//
//  ImageCarouselView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/13.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//https://levelup.gitconnected.com/swiftui-create-an-image-carousel-using-a-timer-ed546aacb389

import SwiftUI
import Combine

// 2
struct ImageCarouselView<Content: View>: View {
    // 3
    private var numberOfImages: Int
    private var content: Content
    
    // 4
    @State private var currentIndex: Int = 0
    
    // 5
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // 6
    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }
    
    var body: some View {
        // 1
        GeometryReader { geometry in
            // 2
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    // 3
                    self.content
                }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading) // 4
                    .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0) // 5
                    .animation(.spring()) // 6
                    .onReceive(self.timer) { _ in
                        // 7
                        self.currentIndex = (self.currentIndex + 1) % 4
                }
                // 2
                HStack(spacing: 3) {
                    // 3
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                        // 4
                        Circle()
                            .frame(width: index == self.currentIndex ? 10 : 8,
                                   height: index == self.currentIndex ? 10 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.white : .gray)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .padding(.bottom, 8)
                            .animation(.spring())
                    }
                }
            }
        }
    }
}

//struct ImageCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCarouselView()
//    }
//}
