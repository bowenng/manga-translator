//
//  BookView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct BookView: View {
    
    // MARK: - View
    
    @State var isAddPageViewShowing: Bool = false
    
    var body: some View {
        Gallery<Page, FullScreenView>(items: pages,
                                    toDestination: toDestination,
                                    numberOfPreviewsPerRow: 2,
                                    numberOfPreviewsPerScreen: 3,
                                    makeContextMenuViewData: makeContextMenuViewData)
            .navigationBarTitle(title, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isAddPageViewShowing = true
            },
                                                 label: {
                Text("New")
            }))
            .sheet(isPresented: $isAddPageViewShowing,
                   onDismiss: {}) {
                Translation(onSaveImage: { image in
                    saveImage(image: image)
                    isAddPageViewShowing = false
                })
            }
    }
    
    // MARK: - ViewModel

    let book: Book
    let onSaveImage: (_ image: Data) -> Void
    let onRemovePage: (_ index: Int) -> Void
}

protocol BookViewModel {
    var title: String { get }
    var pages: [Page] { get }
    func saveImage(image: Data)
    func toDestination(itemIndex: Int) -> FullScreenView
    func makeContextMenuViewData(forItemAtIndex itemIndex: Int) -> [ContextMenuButtonViewData]
}

extension BookView: BookViewModel {
    func makeContextMenuViewData(forItemAtIndex itemIndex: Int) -> [ContextMenuButtonViewData] {
        return [
            ContextMenuButtonViewData(title: "Rename", iconSystemName: "pencil", action: { }, type: .default),
            ContextMenuButtonViewData(title: "Delete", iconSystemName: "trash", action: { onRemovePage(itemIndex) }, type: .destructive)
        ]
    }
    
    var title: String {
        return book.title
    }
    
    var pages: [Page] {
        return book.pages
    }
    
    func saveImage(image: Data) {
        onSaveImage(image)
    }
    
    func toDestination(itemIndex: Int) -> FullScreenView {
        return FullScreenView (image: pages[itemIndex].preview)
    }
}

struct MangaGallery_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookView(book: PreviewData().shelf.books.first!, onSaveImage: {_ in }, onRemovePage: {_ in })
        }
    }
}
