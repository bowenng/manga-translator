//
//  SwipeView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/30/20.
//

import SwiftUI

struct SwipeView: View {
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    let book: Book
    let spacing: CGFloat = 10

    var body: some View {
        ZStack (alignment: .topTrailing) {
            GeometryReader { geometry in
                return ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: spacing) {
                        ForEach(book.pages) { page in
                            FullScreenView(image: page.preview)
                                .frame(width: geometry.size.width)
                        }
                    }
                }
                .content.offset(x: offset)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            offset = value.translation.width - geometry.size.width * CGFloat(index)
                        })
                        .onEnded({ value in
                            if -value.predictedEndTranslation.width > geometry.size.width / 2, index < book.pages.count - 1 {
                                index += 1
                            }
                            if value.predictedEndTranslation.width > geometry.size.width / 2, index > 0 {
                                index -= 1
                            }
                            withAnimation { offset = -(geometry.size.width + spacing) * CGFloat(index) }
                        })
                )
            }
            PageNumberIndicator(pageNumber: index + 1, totalNumberOfPages: book.pages.count)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView(book: PreviewData().shelf.books.first!)
    }
}
