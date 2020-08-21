//
//  TranslatedList.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import SwiftUI

struct TranslatedList: View {
    @ObservedObject var viewModel: TranslatedList.ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.collection.books) { book in
                NavigationLink(
                    destination: MangaGallery(book: book)) {
                    TranslatedListCell(thumbnail: book.thumbnail,
                                       title: book.title,
                                       caption: book.caption)
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                viewModel.addNewBook()
            }, label: {
                Text("New Book")
            }))
        }
    }
    
    init(collection: MangaCollection) {
        self.viewModel = TranslatedList.ViewModel(collection: collection)
    }
}

extension TranslatedList {
    class ViewModel: ObservableObject {
        @Published var collection: MangaCollection
        
        init(collection: MangaCollection) {
            self.collection = collection
        }
        
        func addNewBook() {
            collection.append(MangaBook(title: "Untitled"))
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
        TranslatedList(collection: PreviewData().mangaCollection)
    }
}
