//
//  TranslatedList.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import SwiftUI

struct TranslatedList: View {
    @Binding var collection: MangaCollection
    var body: some View {
        NavigationView {
            List(collection.books) { mangaCollection in
                NavigationLink(
                    destination: MangaGallery(book: mangaCollection)) {
                    TranslatedListCell(thumbnail: mangaCollection.thumbnail,
                                       title: mangaCollection.title,
                                       caption: mangaCollection.caption)
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarItems(trailing: AddBookButton(collection: $collection))
        }
    }
}

extension MangaBook {
    var thumbnail: UIImage {
        return mangaPages.isEmpty ? UIImage(systemName: "photo")! : UIImage(data: mangaPages.first!.image)!
    }
    
    var caption: String {
        let template = "yyyy/MM/dd"
        let dateFormatter = DateFormatter()
        let dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: Locale.current)
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: lastViewed)
    }
}

struct TranslatedList_Previews: PreviewProvider {
    static var previews: some View {
        TranslatedList(collection: .constant(PreviewData().mangaCollection))
    }
}
