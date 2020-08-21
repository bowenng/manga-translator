//
//  MangaCollection.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation

struct MangaCollection {
    var books: [MangaBook] = []
    
    public mutating func append(_ newBook: MangaBook) {
        books.append(newBook)
    }
    
    public mutating func remove(at index: Int) {
        books.remove(at: index)
    }
}
