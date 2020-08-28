//
//  Shelf.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation

class Shelf: ObservableObject {
    @Published var books: [Book]
    let serializer: MangaSerializer = Database.shared
    
    public func append(_ newBook: Book) {
        books.append(newBook)
        serializer.add(book: newBook)
    }
    
    public func remove(at index: Int) {
        let removedBook = books.remove(at: index)
        serializer.remove(book: removedBook)
    }
    
    public func append(_ newPage: Page, toBook index: Int) {
        objectWillChange.send()
        let book = books[index]
        books[index].append(newPage)
        serializer.add(page: newPage, inBook: book)
    }
    
    public func remove(pageAtIndex pageIndex: Int, forBook bookIndex: Int) {
        objectWillChange.send()
        let removedPage = books[bookIndex].remove(pageAtIndex: pageIndex)
        serializer.remove(page: removedPage)
    }
    
    public func rename(bookAtIndex index: Int, newTitle: String) {
        objectWillChange.send()
        books[index].title = newTitle
        let book = books[index]
        serializer.rename(book: book)
    }
    
    init() {
        books = serializer.loadBooks()
    }
}
