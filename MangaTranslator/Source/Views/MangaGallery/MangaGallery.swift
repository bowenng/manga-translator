//
//  MangaGallery.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct MangaGallery: View {
    
    let mangaCollection: MangaCollection
    
    private let layout = [GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible())]
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
            LazyVGrid(columns: layout,
                      alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                ForEach(mangaCollection.mangaPages, id: \.self) { mangaPage in
                    MangaPreview(image: mangaPage.image)
                }
            }
        }
    }
}

struct MangaGallery_Previews: PreviewProvider {
    static var previews: some View {
        MangaGallery(mangaCollection:PreviewData().mangaCollections.first!)
    }
}
