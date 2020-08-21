//
//  Translator.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import Alamofire
import Foundation
import UIKit

protocol Translator {
    func translate(image: Data, completion: @escaping (Result<Data?, AFError>) -> Void)
}
