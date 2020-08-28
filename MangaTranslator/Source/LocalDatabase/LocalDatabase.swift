//
//  LocalDatabase.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/28/20.
//

import Foundation
import SQLite

class Database: MangaSerializer {
    
    public static let shared = Database()
    
    private var database: Connection?
    
    // MARK: - Book
    
    private let booksTable = Table("Book")
    private let bookId = Expression<String>("book_id")
    private let bookTitle = Expression<String>("book_name")
    private let bookCreatedTimeStamp = Expression<Date>("book_created_time_stamp")
    
    // MARK: -  Page
    
    private let pagesTable = Table("Page")
    private let pageId = Expression<String>("page_id")
    private let pageData = Expression<Data>("page_data")
    private let pageCreatedTimeStamp = Expression<Date>("page_created_time_stamp")
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: nil,
                                                                create: true)
            let databaseUrl = documentDirectory.appendingPathComponent("MangaTranslator").appendingPathExtension("sqlite3")
            database = try Connection(databaseUrl.path)
        } catch {
            // TODO: error handling
        }
        initilaizeTables()
    }
    
    private func initilaizeTables() {
        guard let database = database else { return }
        
        do {
            try database.run(booksTable.create(ifNotExists: true) { table in
                table.column(bookId, primaryKey: true)
                table.column(bookTitle)
                table.column(bookCreatedTimeStamp)
            })
            try database.run(pagesTable.create(ifNotExists: true) { table in
                table.column(pageId, primaryKey: true)
                table.column(pageData)
                table.column(pageCreatedTimeStamp)
                table.column(bookId)
                table.foreignKey(bookId, references: booksTable, bookId, delete: .cascade)
            })
        } catch {
            // TODO: error handling
        }
    }
    
    // MARK: - MangaSerializer
    
    func add(book: Book) {
        guard let database = database else { return }
        
        do {
            try database.run(booksTable.insert(bookId <- book.id.uuidString,
                                          bookTitle <- book.title,
                                          bookCreatedTimeStamp <- book.createdTimeStamp))
        } catch {
            // TODO: error handling
        }
    }
    
    func remove(book: Book) {
        guard let database = database else { return }
        
        let bookToDelete = booksTable.filter(bookId == book.id.uuidString)
        do {
            try database.run(bookToDelete.delete())
        } catch {
            // TODO: error handling
        }
    }
    
    func rename(book: Book) {
        guard let database = database else { return }
        
        let bookToRename = booksTable.filter(bookId == book.id.uuidString)
        do {
            try database.run(bookToRename.update(bookTitle <- book.title))
        } catch {
            // TODO: error handling
        }
    }
    
    func add(page: Page, inBook book: Book) {
        guard let database = database else { return }
        
        do {
            try database.run(pagesTable.insert(pageId <- page.id.uuidString,
                                          pageData <- page.image,
                                          pageCreatedTimeStamp <- page.createdTimeStamp,
                                          bookId <- book.id.uuidString))
        } catch {
            // TODO: error handling
        }
    }
    
    func remove(page: Page) {
        guard let database = database else { return }
        
        let pageToDelete = pagesTable.filter(pageId == page.id.uuidString)
        do {
            try database.run(pageToDelete.delete())
        } catch {
            // TODO: error handling
        }
    }
    
    func loadBooks() -> [Book] {
        guard let database = database else { return [] }
        
        var books = [Book]()
        
        do {
            for bookRow in try database.prepare(booksTable) {
                
                do {
                    let title = try bookRow.get(bookTitle)
                    let createdTimeStamp = try bookRow.get(bookCreatedTimeStamp)
                    let uuidString = try bookRow.get(bookId)
                    
                    var book = Book(title: title,
                                    createdTimeStamp: createdTimeStamp,
                                    id: UUID(uuidString: uuidString)!)
                    
                    for pageRow in try database.prepare(pagesTable) {
                        do {
                            let manga = try pageRow.get(pageData)
                            let createdTimeStamp = try pageRow.get(pageCreatedTimeStamp)
                            let uuidString = try pageRow.get(pageId)
                            
                            let page = Page(image: manga, createdTimeStamp: createdTimeStamp, id: UUID(uuidString: uuidString)!)
                            book.pages.append(page)
                        } catch {
                            // TODO: error handling
                        }
                    }
                    
                    book.pages.sort()
                    books.append(book)
                }
                
                books.sort()
            }
        } catch {
            // TODO: error handling
        }
        
        return books
    }
}



extension Date {
    static let iso8601DateFormatter: ISO8601DateFormatter = {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]
        return isoDateFormatter
    }()
    
    var iso8601: String {
        return Self.iso8601DateFormatter.string(from: self)
    }
}

protocol MangaSerializer {
    
    // MARK: - Load shelf
    func loadBooks() -> [Book]
    
    // MARK: - Book Serialization
    
    func add(book: Book)
    func remove(book: Book)
    func rename(book: Book)
    
    // MARK: - Page Serialization
    
    func add(page: Page, inBook book: Book)
    func remove(page: Page)
}

