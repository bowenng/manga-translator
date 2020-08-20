//
//  GoogleCloudTranslator.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/19/20.
//

import Foundation
import Alamofire

class GoogleCloudTranslator: Translator {
    
    let url = "https://us-east1-manga-translator-20200817.cloudfunctions.net/manga-translate"
    
    func translate(image: UIImage, completion: @escaping (Result<UIImage, Error>) -> Void) {
        AF.upload(multipartFormData: constructFormData(image: image),
                  to: url)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else { print("error"); return }
                    let decoded_data = Data(base64Encoded: data)!
                    completion(.success(UIImage(data: decoded_data)!))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private func constructFormData(image: UIImage) -> (MultipartFormData) -> Void {
        let jpegData = image.jpegData(compressionQuality: 0.5)
        return { multipartFormData in
            multipartFormData.append(jpegData!, withName: "manga", fileName: "manga.jpg", mimeType: "image/jpeg")
        }
    }
    
    
}
