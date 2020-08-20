//
//  MangaCollection.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation

struct MangaCollection: Identifiable  {
    let mangaPages: [MangaPage]
    let title: String
    let createdTimeStamp: Date
    
    var id = UUID()
}

extension MangaCollection : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(createdTimeStamp)
    }
}
