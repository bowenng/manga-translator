//
//  ShelfView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/26/20.
//

import SwiftUI

struct ShelfView: View {
    @ObservedObject var viewModel: ShelfView.ViewModel
    
    var body: some View {
        NavigationView {
            Gallery<Book, BookView>(items: viewModel.books,
                                   toDestination: viewModel.toDestination,
                                   numberOfPreviewsPerRow: 2,
                                   numberOfPreviewsPerScreen: 3)
                .navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { viewModel.addNewBook() },
                                                     label: { Text("Add Book")}))
        }
    }
    
    init(shelf: Shelf) {
        self.viewModel = ShelfView.ViewModel(shelf: shelf)
    }
}

extension ShelfView {
    class ViewModel: ObservableObject {
        @Published var shelf: Shelf
        var books: [Book] {
            return shelf.books
        }
        
        init(shelf: Shelf) {
            self.shelf = shelf
        }
        
        func addNewBook() {
            shelf.append(Book(title: "Untitled"))
        }
        
        func toDestination(item: Book) -> BookView {
            return BookView(book: item)
        }
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
        ShelfView(shelf: PreviewData().shelf)
    }
}
