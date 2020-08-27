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
    var lastViewed: Date
    
    var id = UUID()
    
    public init(title: String) {
        self.title = title
        self.lastViewed = Date()
    }
    
    public mutating func append(_ page: Page) {
        pages.append(page)
    }
}

extension Book: Hashable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(lastViewed)
    }
}

extension Book: Viewable {
    var preview: UIImage {
        return pages.isEmpty ? UIImage(named: "manga")! : pages.first!.preview
    }
}
