//
//  BookView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct BookView: View {
    
    // MARK: - View
    
    @State var isActionSheetShowing: Bool = false
    
    var body: some View {
        Gallery<Page, SwipeView>(items: pages,
                                 onPreviewClicked: .navigation(toDestination: toDestination),
                                    numberOfPreviewsPerRow: 2,
                                    numberOfPreviewsPerScreen: 3,
                                    makeContextMenuViewData: makeContextMenuViewData)
            .navigationBarTitle(title, displayMode: .inline)
            .navigationBarItems(trailing:
                IconButton(viewData: ButtonViewData(iconSystemName: "ellipsis",
                                                    action: { isActionSheetShowing = true }))
            )
            .actionSheet(isPresented: $isActionSheetShowing) {
                ActionSheet(title: Text("What action would like to perform?"), buttons: [
                    .default(Text("Rename")) {  },
                    .cancel()
                ])
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
    func toDestination(itemIndex: Int) -> SwipeView
    func makeContextMenuViewData(forItemAtIndex itemIndex: Int) -> [ButtonViewData]
}

extension BookView: BookViewModel {
    
    func makeContextMenuViewData(forItemAtIndex itemIndex: Int) -> [ButtonViewData] {
        return [
            ButtonViewData(title: "Rename", iconSystemName: "pencil", action: { }, type: .default),
            ButtonViewData(title: "Delete", iconSystemName: "trash", action: { onRemovePage(itemIndex) }, type: .destructive)
        ]
    }
    
    var title: String {
        return book.title
    }
    
    var pages: [Page] {
        return book.pages
    }
    
    func toDestination(itemIndex: Int) -> SwipeView {
        return SwipeView(book: book)
    }
}

struct MangaGallery_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookView(book: PreviewData().shelf.books.first!, onSaveImage: {_ in }, onRemovePage: {_ in })
        }
    }
}
