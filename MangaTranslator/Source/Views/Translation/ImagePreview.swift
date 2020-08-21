//
//  ImagePreview.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/19/20.
//

import SwiftUI

struct ImagePreview: View {
    let image: UIImage
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding()
                .frame(maxHeight: .infinity)
        })
    }
}

struct ImagePreview_Previews: PreviewProvider {
    let image = UIImage(systemName: "photo")
    static var previews: some View {
        ImagePreview(image: UIImage(named: "manga")!)
    }
}
