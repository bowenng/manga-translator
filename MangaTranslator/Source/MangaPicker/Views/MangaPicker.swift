//
//  MangaPicker.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import SwiftUI

struct MangaPicker: View {
    let translator: Translator
    @State private var isImagePickerShowing = false
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            ImagePickerButton(title: "Select Manga") { image in
                self.image = translator.translate(image: image)
            }
        }
    }
}

struct MangaPicker_Previews: PreviewProvider {
    static var previews: some View {
        let translator = DummyTranslator()
        return MangaPicker(translator: translator)
    }
}
