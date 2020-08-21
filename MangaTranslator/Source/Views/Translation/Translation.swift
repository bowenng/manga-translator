//
//  Translation.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Alamofire
import SwiftUI

struct Translation: View {
    @State var isImagePickerShowing: Bool = false
    
    @ObservedObject var viewModel = Translation.ViewModel()
    
    var body: some View {
        VStack {
            ImagePreview(image: viewModel.manga)
            
            // Pick Image Button
            Button(action: {
                isImagePickerShowing = true
            }) {
                Text("Select a manga")
                    .bold()
                    .font(.title)
            }
            .sheet(isPresented: $isImagePickerShowing,
                   onDismiss: {},
                   content: {
                    ImagePicker(onImagePicked: viewModel.onImagePicked)
                   })
            // Translate Button
            Button(action:{
                viewModel.translateImage()
            }) {
                Text("Translate")
                    .bold()
                    .font(.title)
            }
            
        }
    }
}

extension Translation {
    class ViewModel: ObservableObject {
        @Published var manga: UIImage
        
        let translator: Translator
        
        init() {
            manga = UIImage(named: "manga")!
            translator = GoogleCloudTranslator()
        }
        
        func onImagePicked(image: UIImage) {
            manga = image
        }
        
        func translateImage() {
            translator.translate(image: manga.jpegData(compressionQuality: 0.5)!,
                                 completion: onImageTranslated)
        }
        
        func onImageTranslated(result: Result<Data?, AFError>) {
            switch result {
            case .success(let data):
                // Todo: Add failure notification
                guard let data = data else { return }
                guard let decodedData = Data(base64Encoded: data) else { return }
                guard let translatedManga = UIImage(data: decodedData) else { return }
                manga = translatedManga
            case .failure(let error):
                // Todo: Add error notification
                print(error)
            }
        }
    }
}

struct Translation_Previews: PreviewProvider {
    static var previews: some View {
        Translation()
    }
}
