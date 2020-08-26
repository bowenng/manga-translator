//
//  Shelf.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation

struct Shelf {
    var books: [Book] = []
    
    public mutating func append(_ newBook: Book) {
        books.append(newBook)
    }
    
    public mutating func remove(at index: Int) {
        books.remove(at: index)
    }
}
