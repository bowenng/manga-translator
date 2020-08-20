//
//  DummyTranslator.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import UIKit
import Foundation

class DummyTranslator: Translator {
    func translate(image: UIImage, completion: @escaping (Result<UIImage, Error>) -> Void) {
        completion(.success(image))
    }
}
