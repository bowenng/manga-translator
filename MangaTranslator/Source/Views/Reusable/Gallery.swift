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
    private let outerPaddingSize: CGFloat
    
    var body: some View {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
                LazyVGrid(columns: layout,
                          alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    ForEach(viewModel.items, id: \.self) { item in
                        NavigationLink(
                            destination: viewModel.toDestination(item)) {
                            Preview(image: item.preview,
                                    config: viewModel.previewConfig)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, outerPaddingSize)
            }
    }
    
    public init(items: [ItemType],
                toDestination: @escaping (_ item: ItemType) -> DetailedView,
                numberOfPreviewsPerRow: Int,
                numberOfPreviewsPerScreen: Int,
                previewCornerRadiusSize: CGFloat = 5.0,
                previewPaddingSize: CGFloat = 3.0,
                previewShadowRadiusSize: CGFloat = 3.0) {
        
        
        let previewConfig = Self.makePreviewConfig(numberOfPreviewsPerRow: numberOfPreviewsPerRow,
                                              numberOfPreviewsPerFrame: numberOfPreviewsPerScreen,
                                              previewCornerRadiusSize: previewCornerRadiusSize,
                                              previewPaddingSize: previewPaddingSize,
                                              previewShadowRadiusSize: previewShadowRadiusSize)
        viewModel = Gallery.ViewModel(items: items,
                                      toDestination: toDestination,
                                      previewConfig: previewConfig)
        layout = Array(repeating: GridItem(.flexible()),
                       count: numberOfPreviewsPerRow)
        outerPaddingSize = previewPaddingSize
    }
    
    
    // MARK: - Helpers
    private static func makePreviewConfig(numberOfPreviewsPerRow: Int,
                                   numberOfPreviewsPerFrame: Int,
                                   previewCornerRadiusSize: CGFloat,
                                   previewPaddingSize: CGFloat,
                                   previewShadowRadiusSize: CGFloat) -> Preview.Config {
        let width: CGFloat = UIScreen.main.bounds.width / CGFloat(numberOfPreviewsPerRow) - 2 * previewPaddingSize
        let height: CGFloat = UIScreen.main.bounds.height / CGFloat(numberOfPreviewsPerFrame) - 2 * previewPaddingSize
        let previewSize: (width: CGFloat, height: CGFloat) = (width: width, height: height)
        return Preview.Config(previewSize: previewSize,
                              cornerRadiusSize: previewCornerRadiusSize,
                              paddingSize: previewPaddingSize,
                              shadowRadiusSize: previewShadowRadiusSize)
    }
}

extension Gallery {
    class ViewModel: ObservableObject {
        /// A list of items being displayed in the gallery
        let items: [ItemType]
        /// A function that transforms an item into a detailed view that will be presented when a preview is clicked
        let toDestination: (_ item: ItemType) -> DetailedView
        let previewConfig: Preview.Config
        
        public init(items: [ItemType],
                    toDestination: @escaping (_ item: ItemType) -> DetailedView,
                    previewConfig: Preview.Config) {
            self.items = items
            self.toDestination = toDestination
            self.previewConfig = previewConfig
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
            Gallery<Page, FullScreenView>(items: items,
                                   toDestination: {FullScreenView(image: $0.preview)},
                                   numberOfPreviewsPerRow: 2, numberOfPreviewsPerScreen: 2)
        }
    }
}
