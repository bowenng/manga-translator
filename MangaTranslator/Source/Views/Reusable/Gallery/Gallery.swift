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
                    ForEach(viewModel.items.indices, id: \.self) { index in
                        let item = viewModel.items[index]
                        switch viewModel.onPreviewClicked {
                        case .navigation(let toDestination):
                            NavigationLink(destination: toDestination(index)) {
                                Preview(image: item.preview,
                                        title: item.previewTitle,
                                        caption: item.previewCaption,
                                        config: viewModel.previewConfig,
                                        options: viewModel.makeContextMenuViewData(index))
                            }
                            .buttonStyle(PlainButtonStyle())
                        case .action(let handler):
                            Button(action: { handler(index) }) {
                                    Preview(image: item.preview,
                                            title: item.previewTitle,
                                            caption: item.previewCaption,
                                            config: viewModel.previewConfig,
                                            options: viewModel.makeContextMenuViewData(index))
                                    
                                   }
                                   .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, outerPaddingSize)
            }
    }
    
    public init(items: [ItemType],
                onPreviewClicked: ClickAction,
                numberOfPreviewsPerRow: Int,
                numberOfPreviewsPerScreen: Int,
                makeContextMenuViewData: @escaping (Int) -> [ButtonViewData] = { _ in [] },
                previewCornerRadiusSize: CGFloat = 5.0,
                previewPaddingSize: CGFloat = 6.0,
                previewShadowRadiusSize: CGFloat = 3.0) {
        
        
        let previewConfig = Self.makePreviewConfig(numberOfPreviewsPerRow: numberOfPreviewsPerRow,
                                              numberOfPreviewsPerFrame: numberOfPreviewsPerScreen,
                                              previewCornerRadiusSize: previewCornerRadiusSize,
                                              previewPaddingSize: previewPaddingSize,
                                              previewShadowRadiusSize: previewShadowRadiusSize)
        viewModel = Gallery.ViewModel(items: items,
                                      onPreviewClicked: onPreviewClicked,
                                      previewConfig: previewConfig,
                                      makeContextMenuViewData: makeContextMenuViewData)
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
    
    enum ClickAction {
        case navigation(toDestination: (Int) -> DetailedView)
        case action(handler: (Int) -> Void)
    }
}

extension Gallery {
    class ViewModel: ObservableObject {
        /// A list of items being displayed in the gallery
        let items: [ItemType]
        /// A function that transforms an item into a detailed view that will be presented when a preview is clicked
        let onPreviewClicked: ClickAction
        let previewConfig: Preview.Config
        let makeContextMenuViewData: (Int) -> [ButtonViewData]
        
        public init(items: [ItemType],
                    onPreviewClicked: ClickAction,
                    previewConfig: Preview.Config,
                    makeContextMenuViewData: @escaping (Int) -> [ButtonViewData]) {
            self.items = items
            self.onPreviewClicked = onPreviewClicked
            self.previewConfig = previewConfig
            self.makeContextMenuViewData = makeContextMenuViewData
        }
    }
}

protocol Viewable {
    var preview: UIImage { get }
    var previewTitle: String? { get }
    var previewCaption: String? { get }
}

struct Gallery_Previews: PreviewProvider {
    static let items: [Page] = PreviewData().shelf.books.first!.pages
    static var previews: some View {
        NavigationView {
            Gallery<Page, FullScreenView>(items: items,
                                          onPreviewClicked: .navigation(toDestination: { FullScreenView(image: items[$0].preview) }),
                                          numberOfPreviewsPerRow: 2,
                                          numberOfPreviewsPerScreen: 2,
                                          makeContextMenuViewData: { _ in return [] })
        }
    }
}


