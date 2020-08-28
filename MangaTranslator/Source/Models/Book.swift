//
//  Book.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation
import SwiftUI

struct Book: Identifiable, Codable {
    var pages: [Page] = []
    var title: String
    var createdTimeStamp: Date = Date()
    var id = UUID()
    
    public mutating func append(_ page: Page) {
        pages.append(page)
    }
    
    public mutating func remove(pageAtIndex index: Int) -> Page {
        return pages.remove(at: index)
    }
}

extension Book: Hashable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(createdTimeStamp)
    }
}

extension Book: Comparable {
    static func < (lhs: Book, rhs: Book) -> Bool {
        return lhs.createdTimeStamp < rhs.createdTimeStamp
    }
}

extension Book: Viewable {
    var preview: UIImage {
        return pages.isEmpty ? UIImage(named: "manga")! : pages.first!.preview
    }
}
