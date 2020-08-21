//
//  MangaPreview.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct MangaPreview: View {
    let image: Data
    
    var body: some View {
        Image(uiImage: UIImage(data: image)!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 200, alignment: .center)
            .clipped()
    }
}

struct MangaPreview_Previews: PreviewProvider {
    static var previews: some View {
        MangaPreview(image: UIImage(named: "manga")!.jpegData(compressionQuality: 1.0)!)
    }
}
