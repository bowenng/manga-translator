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
    
    func translate(image: Data, completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.upload(multipartFormData: constructFormData(image: image),
                  to: url)
            .validate()
            .response { completion($0.result) }
    
    }
    private func constructFormData(image: Data) -> (MultipartFormData) -> Void {
        return { multipartFormData in
            multipartFormData.append(image, withName: "manga", fileName: "manga.jpg", mimeType: "image/jpeg")
        }
    }
}
    
    
    

