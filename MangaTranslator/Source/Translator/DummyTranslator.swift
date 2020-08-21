//
//  DummyTranslator.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import Alamofire
import Foundation
import UIKit

class DummyTranslator: Translator {
    func translate(image: Data, completion: @escaping (Result<Data?, AFError>) -> Void) {
        completion(.success(image))
    }
}
