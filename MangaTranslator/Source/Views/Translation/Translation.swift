//
//  Translation.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Alamofire
import SwiftUI

struct Translation: View {
    
    @ObservedObject var shelf: Shelf
    
    @State var isImagePickerShowing: Bool = false
    @State var isSaveImageViewShowing: Bool = false
    
    // MARK: - Loading states
    @State var isSelectImageButtonDisabled: Bool = false
    @State var isSaveImageButtonDisabled: Bool = true
    @State var loadingDescription: String?
    @State var translationPreviewBlurRadius: CGFloat = 0.0
    
    // MARK: - ViewModel fields
    @State var manga: UIImage?
    
    private let translator: Translator = GoogleCloudTranslator()
    
    // MARK: - body
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                TranslationPreview(image: manga)
                    .blur(radius: translationPreviewBlurRadius)
                
                if let loadingDescription = loadingDescription {
                    LoadingSpinner(description: loadingDescription)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
            Spacer()
            HStack {
                // Pick Image Button
                FloatingIconButton(viewData: ButtonViewData(iconSystemName: "photo.on.rectangle",
                                                        action: { isImagePickerShowing = true },
                                                        type: .default,
                                                        isDisabled: isSelectImageButtonDisabled))
                    .padding(.horizontal, 30)
                .sheet(isPresented: $isImagePickerShowing) {
                        ImagePicker(onImagePicked: onImagePicked)
                       }
                
                // Save Button
                FloatingIconButton(viewData: ButtonViewData(iconSystemName: "square.and.arrow.down",
                                                            action: { isSaveImageViewShowing = true },
                                                            type: .default,
                                                            isDisabled: isSaveImageButtonDisabled))
                    .padding(.horizontal, 30)
                    .sheet(isPresented: $isSaveImageViewShowing) {
                        Save(saveToBook: saveImage,
                             shelf: shelf)
                    }
            }
        }
        .padding(.bottom, 20)
    }
}

protocol TranslationViewModel {
    func saveImage(atBook index: Int)
    func onImagePicked(image: UIImage)
    func translateImage()
    func onImageTranslated(result: Result<Data?, AFError>)
    func onUpload(progress: Progress)
    func onDownload(progress: Progress)
    func onComplete()
}

extension Translation: TranslationViewModel {
    
    func saveImage(atBook index: Int) {
        guard let manga = manga else { return }
        shelf.append(Page(image: manga.jpegData(compressionQuality: 1.0)!), toBook: index)
        isSaveImageViewShowing = false
    }
    
    func onImagePicked(image: UIImage) {
        manga = image
        translateImage()
    }
    
    func translateImage() {
        guard let manga = manga else { return }
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
        isSelectImageButtonDisabled = true
        isSaveImageButtonDisabled = true
        translationPreviewBlurRadius = 10.0
        loadingDescription = progress.fractionCompleted < 1.0 ? "Uploading manga: \(progress.fractionCompleted * 100)..." : "Translating..."
    }
    
    func onDownload(progress: Progress) {
        isSelectImageButtonDisabled = true
        isSaveImageButtonDisabled = true
        translationPreviewBlurRadius = 10.0
        loadingDescription = "Downloading translated manga: \(progress.fractionCompleted * 100)..."
    }
    
    func onComplete() {
        isSelectImageButtonDisabled = false
        isSaveImageButtonDisabled = false
        translationPreviewBlurRadius = 0.0
        loadingDescription = nil
    }
    
}

struct Translation_Previews: PreviewProvider {
    static var previews: some View {
        Translation(shelf: Shelf())
    }
}
