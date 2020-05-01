//
//  FirebaseImageView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/18.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import Combine
//import FirebaseStorage

struct FirebaseImageView: View {
    @ObservedObject var imageLoader:DataLoader
    @State var image:UIImage = UIImage()
    
    init(imageURL: String) {
        imageLoader = DataLoader(urlString:imageURL)
    }

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}


class DataLoader: ObservableObject {
//    PassthroughSubject<Data, Never> ?
//    didchange?
//    send ? 要勉強

    @Published var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        getDataFromURL(urlString: urlString)
    }
    
//    https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui
    func getDataFromURL(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)  //不要?
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

