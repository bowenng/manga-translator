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
    @State private var image: UIImage = UIImage(named: "manga")!
    
    var body: some View {
        VStack {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                ImagePreview(image: $image)
            })
            
            ImagePickerButton(title: "Select Manga") { image in
                translator.translate(image: image) { result in
                    switch result {
                    case .success(let image):
                        self.image = image
                    case .failure(let error):
                        print(error)
                    }
                }
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
