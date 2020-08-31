//
//  SaveView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/30/20.
//

import SwiftUI

struct Save: View {
    
    // MARK: - ViewModel
    let saveToBook: (Int) -> Void
    @ObservedObject var shelf: Shelf
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Gallery<Book, BookView>(items: books,
                                    onPreviewClicked: .action(handler: onBookSelected),
                                   numberOfPreviewsPerRow: 2,
                                   numberOfPreviewsPerScreen: 3,
                                   makeContextMenuViewData: { _ in [] },
                                   previewPaddingSize: 30)
            FloatingIconButton(viewData: ButtonViewData(iconSystemName: "plus",
                                                        action: addNewBook))
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 40)
        }
    }
}

protocol SaveViewModel {
    func onBookSelected(at index: Int)
    func addNewBook()
}

extension Save: SaveViewModel {
    func onBookSelected(at index: Int) {
        saveToBook(index)
    }
    
    var books: [Book] {
        return shelf.books
    }
    
    func addNewBook() {
        shelf.append(Book(title: "Untitled"))
    }
}


struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        Save(saveToBook: { _ in },
             shelf: Shelf())
    }
}
