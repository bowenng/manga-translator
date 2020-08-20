//
//  PreviewData.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation
import UIKit

struct PreviewData {
    let mangaCollections: [MangaCollection]
    
    init() {
        var collections = [MangaCollection]()
        for _ in 0...5 {
            collections.append(PreviewData.makeCollection())
        }
        self.mangaCollections = collections
    }
    
    private static func makeCollection() -> MangaCollection {
        var pages = [MangaPage]()
        for _ in 0...5 {
            pages.append(MangaPage(image: UIImage(named: "manga")!.jpegData(compressionQuality: 1.0)!, title: "manga1", createdTimeStamp: Date()))
        }
        return MangaCollection(mangaPages: pages, title: "manga", createdTimeStamp: Date())
    }
}

