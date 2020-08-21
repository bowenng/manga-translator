//
//  MangaCollection.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation

class MangaCollection: ObservableObject {
    @Published var books: [MangaBook] = []
    
    public func append(_ newBook: MangaBook) {
        books.append(newBook)
    }
    
    public func remove(at index: Int) {
        books.remove(at: index)
    }
}
