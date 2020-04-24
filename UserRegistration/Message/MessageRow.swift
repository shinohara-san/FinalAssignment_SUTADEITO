//
//  MessageRow.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/23.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
import SwiftUI

struct MessageRow: View {
    var message = ""
    var isMyMessage = false

    var body: some View {
        HStack {
            if isMyMessage {
                Spacer()

                Text(message)
                .padding(8)
                .background(Color.red)
                .cornerRadius(6)
                .foregroundColor(Color.white)
            } else {
                VStack(alignment: .leading) {
                    Text(message)
                    .padding(8)
                    .background(Color.green)
                    .cornerRadius(6)
                    .foregroundColor(Color.white)

                }

                Spacer()
            }
        }
    }
}

struct messageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(message: "Hoge", isMyMessage: false)
    }
}
