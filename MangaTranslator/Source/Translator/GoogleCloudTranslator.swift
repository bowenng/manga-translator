//
//  GoogleCloudTranslator.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/19/20.
//

import Foundation
import Alamofire

class GoogleCloudTranslator: Translator {
    func translate(image: Data, completion: @escaping (Result<Data?, AFError>) -> Void, onUpload: ((Progress) -> Void)?, onDownload: ((Progress) -> Void)?) {
        AF.upload(multipartFormData: constructFormData(image: image),
                  to: url)
            .validate()
            .response { completion($0.result) }
            .uploadProgress() { progress in
                guard let onUpload = onUpload else { return }
                onUpload(progress)
            }
            .downloadProgress() { progress in
                guard let onDownload = onDownload else { return }
                onDownload(progress)
            }
    }
    
    
    let url = "https://us-east1-manga-translator-20200817.cloudfunctions.net/manga-translate"
    
    private func constructFormData(image: Data) -> (MultipartFormData) -> Void {
        return { multipartFormData in
            multipartFormData.append(image, withName: "manga", fileName: "manga.jpg", mimeType: "image/jpeg")
        }
    }
}
    
    
    

