//
//  Gallery.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/26/20.
//

import SwiftUI

struct Gallery<ItemType: Hashable & Viewable, DetailedView: View>: View {
    @ObservedObject var viewModel: Gallery.ViewModel
    
    private let layout: [GridItem]
    
    var body: some View {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
                LazyVGrid(columns: layout,
                          alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    ForEach(viewModel.items, id: \.self) { item in
                        NavigationLink(
                            destination: viewModel.toDestination(item)) {
                            Preview(image: item.preview,
                                    previewSize: viewModel.previewSize)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
    }
    
    public init(items: [ItemType],
                toDestination: @escaping (_ item: ItemType) -> DetailedView,
                numberOfPreviewsPerRow: Int,
                previewSize: (width: CGFloat, height: CGFloat)) {
        viewModel = Gallery.ViewModel(items: items,
                                      toDestination: toDestination,
                                      previewSize: previewSize)
        layout = Array(repeating: GridItem(.flexible()),
                       count: numberOfPreviewsPerRow)
    }
}

extension Gallery {
    class ViewModel: ObservableObject {
        /// A list of items being displayed in the gallery
        let items: [ItemType]
        /// A function that transforms an item into a detailed view that will be presented when a preview is clicked
        let toDestination: (_ item: ItemType) -> DetailedView
        let previewSize: (width: CGFloat, height: CGFloat)
        
        public init(items: [ItemType],
                    toDestination: @escaping (_ item: ItemType) -> DetailedView,
                    previewSize: (width: CGFloat, height: CGFloat)) {
            self.items = items
            self.toDestination = toDestination
            self.previewSize = previewSize
        }
    }
}

protocol Viewable {
    var preview: UIImage { get }
}

struct Gallery_Previews: PreviewProvider {
    static let items: [Page] = PreviewData().shelf.books.first!.pages
    static var previews: some View {
        NavigationView {
            Gallery<Page, Preview>(items: items,
                                   toDestination: {Preview(image: $0.preview, previewSize: (width: 100, height: 200))},
                                        numberOfPreviewsPerRow: 3,
                                        previewSize: (width: 100, height: 200))
        }
    }
}
