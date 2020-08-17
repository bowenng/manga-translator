//
//  OfflineTranslator.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import Foundation
import UIKit
import SwiftyTesseract


class OfflineTranslator: Translator {
    private let tesseract = SwiftyTesseract(languages: [.korean],
                                            dataSource: LanguageModelDataSource,
                                            engineMode: .lstmOnly)
    
    func translate(image: UIImage) -> UIImage {
        let _ = tesseract.performOCR(on: image)
        let result = tesseract.recognizedBlocks(for: .block)
        switch result {
        case .success(let blocks):
            for block in blocks {
                print(block)
            }
        case .failure(let error):
            print(error)
        }
        return image
    }
}

struct KoreanDataSource: LanguageModelDataSource {
    var pathToTrainedData: String {
        if let resourcePath = Bundle.main.resourcePath {
            let imgName = "dog.png"
            let path = resourcePath + "/" + imgName
        }
    }
}
