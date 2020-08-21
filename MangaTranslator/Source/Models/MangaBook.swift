//
//  MangaCollection.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation
import SwiftUI

class MangaBook: Identifiable, ObservableObject  {
    @Published var mangaPages: [MangaPage] = []
    @Published var title: String
    @Published var lastViewed: Date
    
    var id = UUID()
    
    public init(title: String) {
        self.title = title
        self.lastViewed = Date()
    }
    
    public func append(_ page: MangaPage) {
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
