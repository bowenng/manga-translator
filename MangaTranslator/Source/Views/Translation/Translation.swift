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
            TranslationPreview(image: viewModel.manga)
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
            
            // Pick Image Button
            FloatingButton(viewData: ButtonViewData(title: "Select a Manga",
                                                    iconSystemName: "photo.on.rectangle",
                                                    action: { isImagePickerShowing = true },
                                                    type: .default))
                .padding(.horizontal, 30)
            .sheet(isPresented: $isImagePickerShowing,
                   onDismiss: {},
                   content: {
                    ImagePicker(onImagePicked: viewModel.onImagePicked)
                   })
            // Translate Button
            FloatingButton(viewData: ButtonViewData(title: "Translate",
                                                    iconSystemName: "doc.richtext",
                                                    action: { viewModel.translateImage() },
                                                    type: .default))
                .padding(.horizontal, 30)
            
            // Save Button
            FloatingButton(viewData: ButtonViewData(title: "Save",
                                                    iconSystemName: "square.and.arrow.down",
                                                    action: { viewModel.saveImage() },
                                                    type: .default))
                .padding(.horizontal, 30)
        }
        .padding(.bottom, 20)
    }
    
    init(onSaveImage: @escaping (Data) -> Void) {
        self.viewModel = Translation.ViewModel(onSaveImage: onSaveImage)
    }
}

extension Translation {
    class ViewModel: ObservableObject {
        
        @Published var manga: UIImage
        
        private let onSaveImage: (Data) -> Void
        private let translator: Translator

        
        init(onSaveImage: @escaping (Data) -> Void) {
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
                                 completion: onImageTranslated,
                                 onUpload: onUpload,
                                 onDownload: onDownload)
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
        
        func onUpload(progres: Progress) {
            
        }
        
        func onDownload(progres: Progress) {
            
        }
    }
}

struct Translation_Previews: PreviewProvider {
    static var previews: some View {
        Translation() { _ in
            
        }
    }
}
