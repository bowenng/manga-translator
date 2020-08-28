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

    @EnvironmentObject var shelf: Shelf
    let bookIndex: Int
}

protocol BookViewModel {
    var title: String { get }
    var pages: [Page] { get }
    func saveImage(image: Data)
    func toDestination(itemIndex: Int) -> FullScreenView
    func makeContextMenuViewData(forItemAtIndex itemIndex: Int) -> [ContextMenuItemViewData]
}

extension BookView: BookViewModel {
    func makeContextMenuViewData(forItemAtIndex itemIndex: Int) -> [ContextMenuItemViewData] {
        return [
            ContextMenuItemViewData(title: "Rename", iconSystemName: "pencil", action: { self.shelf.remove(pageAtIndex: itemIndex, forBook: bookIndex) }, type: .default),
            ContextMenuItemViewData(title: "Delete", iconSystemName: "trash", action: {}, type: .destructive)
        ]
    }
    
    var title: String {
        return shelf.books[bookIndex].title
    }
    
    var pages: [Page] {
        return shelf.books[bookIndex].pages
    }
    
    func saveImage(image: Data) {
        shelf.append(Page(image: image), toBook: bookIndex)
    }
    
    func toDestination(itemIndex: Int) -> FullScreenView {
        return FullScreenView (image: pages[itemIndex].preview)
    }
}

struct MangaGallery_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookView(bookIndex: 0)
        }.environmentObject(Shelf())
    }
}
