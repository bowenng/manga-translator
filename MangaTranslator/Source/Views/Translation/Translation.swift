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
    @ObservedObject var viewModel: Translation.ViewModel
    
    var body: some View {
        VStack {
            FullScreenView(image: viewModel.manga)
            
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
            
            // Save Button
            Button(action:{
                viewModel.saveImage()
            }) {
                Text("Save")
                    .bold()
                    .font(.title)
            }
            
        }
    }
    
    init(book: Book,
         onSaveImage: @escaping (Data) -> Void) {
        self.viewModel = Translation.ViewModel(book: book,
                                               onSaveImage: onSaveImage)
    }
}

extension Translation {
    class ViewModel: ObservableObject {
        
        @Published var manga: UIImage
        @Published var book: Book
        
        private let onSaveImage: (Data) -> Void
        private let translator: Translator

        
        init(book: Book,
             onSaveImage: @escaping (Data) -> Void) {
            self.book = book
            self.onSaveImage = onSaveImage
            manga = UIImage(named: "manga")!
            translator = GoogleCloudTranslator()
        }
        
        func saveImage() {
            self.onSaveImage(manga.jpegData(compressionQuality: 1.0)!)
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
        Translation(book: PreviewData().shelf.books.first!) { _ in
            
        }
    }
}
