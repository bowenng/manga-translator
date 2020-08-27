//
//  PreviewData.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation
import UIKit

struct PreviewData {
    var shelf: Shelf = Shelf()
    
    init() {
        for _ in 0...5 {
            shelf.append(PreviewData.makeShelf())
        }
    }
    
    private static func makeShelf() -> Book {
        var book = Book(title: "manga")
        for _ in 0...5 {
            book.append(Page(image: UIImage(named: "manga")!.jpegData(compressionQuality: 1.0)!))
        }
        return book
    }
}

