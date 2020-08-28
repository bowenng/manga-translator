//
//  ShelfView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/26/20.
//

import SwiftUI

struct ShelfView: View {
    
    // MARK: - ViewModel
    @ObservedObject var shelf: Shelf
    
    var body: some View {
        NavigationView {
            Gallery<Book, BookView>(items: books,
                                   toDestination: toDestination,
                                   numberOfPreviewsPerRow: 2,
                                   numberOfPreviewsPerScreen: 3,
                                   makeContextMenuViewData: makeContextMenuViewData)
                .navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { addNewBook() },
                                                     label: { Text("Add Book")}))
        }
    }
}

protocol ShelfViewModel {
    func addNewBook()
    func toDestination(itemIndex: Int) -> BookView
    func makeContextMenuViewData(forItemAtIndex itemIndex: Int) -> [ContextMenuButtonViewData]
}

extension ShelfView: ShelfViewModel {
    var books: [Book] {
        return shelf.books
    }
    
    func makeContextMenuViewData(forItemAtIndex itemIndex: Int) -> [ContextMenuButtonViewData] {
        return [
            ContextMenuButtonViewData(title: "Rename", iconSystemName: "pencil", action: { }, type: .default),
            ContextMenuButtonViewData(title: "Delete", iconSystemName: "trash", action: { self.shelf.remove(at: itemIndex) }, type: .destructive)
        ]
    }
    
    func addNewBook() {
        shelf.append(Book(title: "Untitled"))
    }
    
    func toDestination(itemIndex: Int) -> BookView {
        return BookView(book: shelf.books[itemIndex],
                        onSaveImage: { image in
                            let newPage = Page(image: image)
                            shelf.append(newPage, toBook: itemIndex)
                        },
                        onRemovePage: { pageIndex in
                            shelf.remove(pageAtIndex: pageIndex, forBook: itemIndex)
                        })
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
        return dateFormatter.string(from: createdTimeStamp)
    }
}

struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView(shelf: Shelf())
    }
}
