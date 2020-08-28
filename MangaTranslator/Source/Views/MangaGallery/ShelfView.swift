//
//  ShelfView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/26/20.
//

import SwiftUI

struct ShelfView: View {
    
    // MARK: - ViewModel
    @EnvironmentObject var shelf: Shelf
    
    var body: some View {
        NavigationView {
            Gallery<Book, BookView>(items: books,
                                   toDestination: toDestination,
                                   numberOfPreviewsPerRow: 2,
                                   numberOfPreviewsPerScreen: 3,
                                   makeContextMenuViewData: { _ in return [] })
                .navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { addNewBook() },
                                                     label: { Text("Add Book")}))
        }
    }
}

protocol ShelfViewModel {
    func addNewBook()
    func toDestination(itemIndex: Int) -> BookView
}

extension ShelfView: ShelfViewModel {
    var books: [Book] {
        return shelf.books
    }
    
    func addNewBook() {
        shelf.append(Book(title: "Untitled"))
    }
    
    func toDestination(itemIndex: Int) -> BookView {
        return BookView(bookIndex: itemIndex)
    }
}

extension Book {
    var thumbnail: UIImage {
        return pages.isEmpty ? UIImage(systemName: "photo")! : UIImage(data: pages.first!.image)!
    }
    
    var caption: String {
        let template = "yyyy/MM/dd"
        let dateFormatter = DateFormatter()
        let dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: Locale.current)
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: lastViewed)
    }
}

struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView().environmentObject(Shelf())
    }
}
