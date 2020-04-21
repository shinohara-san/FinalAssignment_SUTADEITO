//
//  MatchView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct MatchView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<10) {
                    Text("Item \($0)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: 200, height: 200)
                        .background(Color.red)
                } //foreach
            } //vstack
        } //scroll
        .onAppear{
            print("スクロールビュー")
        }
    } //body
} //struct

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
