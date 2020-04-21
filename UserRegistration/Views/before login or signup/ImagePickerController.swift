//
//  ImagePickerController.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/18.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseStorage

//UIKitの操作を担当するファイル
//https://www.hackingwithswift.com/books/ios-swiftui/using-coordinators-to-manage-swiftui-view-controllers

struct imagePicker : UIViewControllerRepresentable { //UIViewController

@Binding var shown: Bool
@Binding var imageURL:String
@Binding var email: String
    
@EnvironmentObject var shareData: ShareData


//初期画面      UIViewController
func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> UIImagePickerController {
    //imagepic = UIImagePickerControllerを返り値として返す
    //imagepicにタイプとデリゲートを設定
        let imagepic = UIImagePickerController()
        imagepic.sourceType = .photoLibrary
        imagepic.delegate = context.coordinator
        return imagepic
}

func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
    
}

//makeCoordinatorは自動で発動。このimagePicker構造体のCoordinatorを返すが、そのときにparent1にimagePicker自身を設定
func makeCoordinator() -> imagePicker.Coordinator {
//       return imagePicker.Coordinator(parent1: self, date: Date())
    return imagePicker.Coordinator(parent1: self, email: email)
   }

//Coordinatorの親要素はimagePickerであると初期化
class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var parent: imagePicker
    var email: String
    init(parent1: imagePicker, email: String) {
//    init(parent1: imagePicker) {
        parent = parent1
        self.email = email
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.shown.toggle()
    }
    
    //storageに画像を投げる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        let storage = Storage.storage().reference()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
//        let date = Date()
        storage.child("images/pictureOf_\(email)").putData(image.jpegData(compressionQuality: 0.35)!, metadata: metadata){ (_, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
  
            print("Uploading Success!")
            
            self.downloadImageFromFirebase()
        }
//        parent.shown.toggle()
    }
    
    func downloadImageFromFirebase() {
        // Create a reference to the file you want to download
        let storage = Storage.storage().reference()
        storage.child("images/pictureOf_\(email)").downloadURL { (url, error) in
            if error != nil {
                // Handle any errors
                print((error?.localizedDescription)!)
                print("エラー: ImagePickerController")
                return
            }
//            print("Download success")
            //self.parent = imagePickerのimageURLに取得したURLを代入
            self.parent.imageURL = "\(url!)"
            // ピッカーを下ろす
            self.parent.shown.toggle()
            
            // self.listOfImageFile()
        }
    }
    
    //        func listOfImageFile() {
    //            let storageReference = Storage.storage().reference().child("images/")
    //            storageReference.listAll { (result, error) in
    //              if error != nil {
    //                  // Handle any errors
    //                  print((error?.localizedDescription)!)
    //                  return
    //              }
    //              for prefix in result.prefixes {
    //                // The prefixes under storageReference.
    //                // You may call listAll(completion:) recursively on them.
    //                print("prefix is \(prefix)")
    //              }
    //              for item in result.items {
    //                // The items under storageReference.
    //                print("items is \(item)")
    //              }
    //            }
    //        }
    
    }
}
