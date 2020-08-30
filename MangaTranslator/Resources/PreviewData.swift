//
//  PreviewData.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation
import UIKit

struct PreviewData {
    let shelf: Shelf = Shelf()
    
    init() {
        for i in 0...5 {
            shelf.books.append(Book(title: "Untitled"))
            for _ in 0...2 {
                let newPage = Page(image: UIImage(named: "manga")!.jpegData(compressionQuality: 1.0)!)
                shelf.books[i].pages.append(newPage)
            }
        }
    }
}

