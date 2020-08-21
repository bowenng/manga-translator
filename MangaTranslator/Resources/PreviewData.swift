//
//  PreviewData.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation
import UIKit

struct PreviewData {
    var mangaCollection: MangaCollection = MangaCollection()
    
    init() {
        for _ in 0...5 {
            mangaCollection.append(PreviewData.makeCollection())
        }
    }
    
    private static func makeCollection() -> MangaBook {
        var book = MangaBook(title: "manga")
        for _ in 0...5 {
            book.append(MangaPage(image: UIImage(named: "manga")!.jpegData(compressionQuality: 1.0)!, createdTimeStamp: Date()))
        }
        return book
    }
}

