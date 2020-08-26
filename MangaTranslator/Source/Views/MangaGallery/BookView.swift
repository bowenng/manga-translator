//
//  BookView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct BookView: View {
    @State var isAddPageViewShowing: Bool = false
    @ObservedObject var viewModel: BookView.ViewModel
    
    var body: some View {
        Gallery<Page, FullScreenView>(items: viewModel.pages,
                                    toDestination: viewModel.toDestination,
                                    numberOfPreviewsPerRow: 2,
                                    numberOfPreviewsPerScreen: 3)
            .navigationBarTitle(viewModel.title, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isAddPageViewShowing = true
            },
                                                 label: {
                Text("New")
            }))
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 5)
            .sheet(isPresented: $isAddPageViewShowing,
                   onDismiss: {}) {
                Translation(book: viewModel.book, onSaveImage: { image in
                    viewModel.saveImage(image: image)
                    isAddPageViewShowing = false
                })
            }
    }
    
    init(book: Book) {
        self.viewModel = BookView.ViewModel(book: book)
    }
}

extension BookView {
    class ViewModel: ObservableObject {
        @Published var book: Book
        
        var title: String {
            return book.title
        }
        
        var pages: [Page] {
            return book.pages
        }
        
        init(book: Book) {
            self.book = book
        }
        
        func saveImage(image: Data) {
            book.append(Page(image: image, createdTimeStamp: Date()))
        }
        
        func toDestination(item: Page) -> FullScreenView {
            return FullScreenView (image: item.preview)
        }
    }
}

struct MangaGallery_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookView(book:PreviewData().shelf.books.first!)
        }
    }
}
