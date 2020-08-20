//
//  MangaPage.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation

struct MangaPage: Codable, Identifiable {
    let image: Data
    let title: String
    let createdTimeStamp: Date
    
    var id = UUID()
}

extension MangaPage : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(createdTimeStamp)
    }
}
