//
//  AddBookButton.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct AddBookButton: View {
    @Binding var collection: MangaCollection
    
    var body: some View {
        Button(action: {
            collection.append(MangaBook(title: "Untitled"))
        }, label: {
            Text("New Book")
        })
    }
}

struct AddBookButton_Previews: PreviewProvider {
    static var previews: some View {
        AddBookButton(collection: .constant(MangaCollection()))
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
