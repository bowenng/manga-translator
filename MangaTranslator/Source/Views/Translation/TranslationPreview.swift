//
//  TranslationPreview.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/28/20.
//

import SwiftUI

struct TranslationPreview: View {
    let image: UIImage?
    
    var body: some View {
        HStack {
            if let image = image {
                ScrollView(.vertical, showsIndicators: true) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
                }
            } else {
                Text("Select a picture to get started")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct TranslationPreview_Previews: PreviewProvider {
    static var previews: some View {
        TranslationPreview(image: UIImage(named: "manga")!)
    }
}
