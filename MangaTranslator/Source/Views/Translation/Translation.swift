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
    
    // MARK: - Loading states
    @State var areButtonsDisabled: Bool = false
    @State var loadingDescription: String?
    @State var translationPreviewBlurRadius: CGFloat = 0.0
    
    // MARK: - ViewModel fields
    @State var manga: UIImage = UIImage(named: "manga")!
    
    private let onSaveImage: (Data) -> Void
    private let translator: Translator = GoogleCloudTranslator()
    
    // MARK: - body
    
    var body: some View {
        VStack {
            ZStack {
                TranslationPreview(image: manga)
                    .blur(radius: translationPreviewBlurRadius)
                if let loadingDescription = loadingDescription {
                    LoadingSpinner(description: loadingDescription)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
                
            
            // Pick Image Button
            FloatingButton(viewData: ButtonViewData(title: "Select a Manga",
                                                    iconSystemName: "photo.on.rectangle",
                                                    action: { isImagePickerShowing = true },
                                                    type: .default,
                                                    isDisabled: areButtonsDisabled))
                .padding(.horizontal, 30)
            .sheet(isPresented: $isImagePickerShowing,
                   onDismiss: {},
                   content: {
                    ImagePicker(onImagePicked: onImagePicked)
                   })
            
            // Translate Button
            FloatingButton(viewData: ButtonViewData(title: "Translate",
                                                    iconSystemName: "doc.richtext",
                                                    action: { translateImage() },
                                                    type: .default,
                                                    isDisabled: areButtonsDisabled))
                .padding(.horizontal, 30)
            
            // Save Button
            FloatingButton(viewData: ButtonViewData(title: "Save",
                                                    iconSystemName: "square.and.arrow.down",
                                                    action: { saveImage() },
                                                    type: .default,
                                                    isDisabled: areButtonsDisabled))
                .padding(.horizontal, 30)
        }
        .padding(.bottom, 20)
    }
    
    init(onSaveImage: @escaping (Data) -> Void) {
        self.onSaveImage = onSaveImage
    }
}

protocol TranslationViewModel {
    func saveImage()
    func onImagePicked(image: UIImage)
    func translateImage()
    func onImageTranslated(result: Result<Data?, AFError>)
    func onUpload(progress: Progress)
    func onDownload(progress: Progress)
    func onComplete()
}

extension Translation: TranslationViewModel {
    
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
        onComplete()
    }
    
    // MARK: - UI updates on translation progress
    
    func onUpload(progress: Progress) {
        areButtonsDisabled = true
        translationPreviewBlurRadius = 10.0
        loadingDescription = progress.fractionCompleted < 1.0 ? "Uploading manga: \(progress.fractionCompleted * 100)..." : "Translating..."
    }
    
    func onDownload(progress: Progress) {
        areButtonsDisabled = true
        translationPreviewBlurRadius = 10.0
        loadingDescription = "Downloading translated manga: \(progress.fractionCompleted * 100)..."
    }
    
    func onComplete() {
        areButtonsDisabled = false
        translationPreviewBlurRadius = 0.0
        loadingDescription = nil
    }
    
}

struct Translation_Previews: PreviewProvider {
    static var previews: some View {
        Translation() { _ in
            
        }
    }
}
