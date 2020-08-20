//
//  Translator.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import UIKit
import Foundation

protocol Translator {
    func translate(image: UIImage, completion: @escaping (Result<UIImage, Error>) -> Void)
}
