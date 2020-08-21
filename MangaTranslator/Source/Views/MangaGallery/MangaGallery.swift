//
//  MangaGallery.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct MangaGallery: View {
    
    @State var isAddPageViewShowing: Bool = false
    @ObservedObject var viewModel: MangaGallery.ViewModel
    
    private let layout = [GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible())]
    
    var body: some View {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
                LazyVGrid(columns: layout,
                          alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    ForEach(viewModel.pages, id: \.self) { mangaPage in
                        NavigationLink(
                            destination: MangaDetailedView(image: mangaPage.image)) {
                            MangaPreview(image: mangaPage.image)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }.navigationBarTitle(viewModel.title, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isAddPageViewShowing = true
            },
                                                 label: {
                Text("New")
            }))
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .sheet(isPresented: $isAddPageViewShowing, onDismiss: {}) {
                Translation(book: viewModel.book, onSaveImage: { image in
                    viewModel.saveImage(image: image)
                    isAddPageViewShowing = false
                })
            }
    }
    
    init(book: MangaBook) {
        self.viewModel = MangaGallery.ViewModel(book: book)
    }
}

extension MangaGallery {
    class ViewModel: ObservableObject {
        @Published var book: MangaBook
        
        var title: String {
            return book.title
        }
        
        var pages: [MangaPage] {
            return book.mangaPages
        }
        
        init(book: MangaBook) {
            self.book = book
        }
        
        func saveImage(image: Data) {
            book.append(MangaPage(image: image, createdTimeStamp: Date()))
        }
    }
}

struct MangaGallery_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MangaGallery(book:PreviewData().mangaCollection.books.first!)
        }
    }
}
