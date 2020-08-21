//
//  MangaGallery.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct MangaGallery: View {
    
    let book: MangaBook
    
    private let layout = [GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible())]
    
    var body: some View {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
                LazyVGrid(columns: layout,
                          alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    ForEach(book.mangaPages, id: \.self) { mangaPage in
                        NavigationLink(
                            destination: MangaDetailedView(image: mangaPage.image)) {
                            MangaPreview(image: mangaPage.image)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }.navigationBarTitle(book.title, displayMode: .inline)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        
    }
}

struct MangaGallery_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MangaGallery(book:PreviewData().mangaCollection.books.first!)
        }
    }
}
