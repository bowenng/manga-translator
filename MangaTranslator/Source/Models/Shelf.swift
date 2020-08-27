//
//  Shelf.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation

class Shelf: ObservableObject {
    @Published var books: [Book] = []
    
    public func append(_ newBook: Book) {
        books.append(newBook)
    }
    
    public func remove(at index: Int) {
        books.remove(at: index)
    }
    
    public func append(_ newPage: Page, toBook index: Int) {
        objectWillChange.send()
        books[index].append(newPage)
    }
}
