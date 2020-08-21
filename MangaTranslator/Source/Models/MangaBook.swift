//
//  MangaCollection.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation
import SwiftUI

struct MangaBook: Identifiable {
    var mangaPages: [MangaPage] = []
    var title: String
    var lastViewed: Date
    
    var id = UUID()
    
    public init(title: String) {
        self.title = title
        self.lastViewed = Date()
    }
    
    public mutating func append(_ page: MangaPage) {
        mangaPages.append(page)
    }
}

extension MangaBook : Hashable {
    static func == (lhs: MangaBook, rhs: MangaBook) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(lastViewed)
    }
}
