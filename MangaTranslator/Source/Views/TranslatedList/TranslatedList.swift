//
//  TranslatedList.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import SwiftUI

struct TranslatedList: View {
    let mangaCollections: [MangaCollection]
    var body: some View {
        NavigationView {
            List(mangaCollections) { mangaCollection in
                NavigationLink(
                    destination: MangaGallery(mangaCollection: mangaCollection)) {
                    TranslatedListCell(thumbnail: mangaCollection.thumbnail,
                                       title: mangaCollection.title,
                                       caption: mangaCollection.caption)
                }
            }.navigationTitle("Manga Collection")
        }
    }
}

extension MangaCollection {
    var thumbnail: UIImage {
        return mangaPages.isEmpty ? UIImage(systemName: "photo")! : UIImage(data: mangaPages.first!.image)!
    }
    
    var caption: String {
        let template = "yyyy/MM/dd"
        let dateFormatter = DateFormatter()
        let dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: Locale.current)
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: createdTimeStamp)
    }
}

struct TranslatedList_Previews: PreviewProvider {
    static var previews: some View {
        TranslatedList(mangaCollections: PreviewData().mangaCollections)
    }
}
