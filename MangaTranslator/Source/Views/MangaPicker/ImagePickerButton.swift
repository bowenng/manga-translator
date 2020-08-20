//
//  ImagePickerButton.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import SwiftUI

struct ImagePickerButton: View {
    let title: String
    let onImageSelected: (_ image: UIImage) -> ()
    
    @State private var isImagePickerShowing = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        Button(action: {
            isImagePickerShowing = true
        }) {
            Text(title)
                .foregroundColor(Color.black)
                .bold()
                .font(.title)
                .colorScheme(.light)
        }
        .sheet(isPresented: $isImagePickerShowing,
               onDismiss: {
                guard let selectedImage = selectedImage else { return }
                onImageSelected(selectedImage)
               },
               content: {
                ImagePicker(image: $selectedImage)
               })
    }
}

struct ImagePickerButton_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerButton(
            title: "漫画を選択",
            onImageSelected: {_ in }
        )
    }
}
