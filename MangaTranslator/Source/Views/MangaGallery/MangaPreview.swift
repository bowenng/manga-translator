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
            .aspectRatio(contentMode: .fit)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct MangaPreview_Previews: PreviewProvider {
    static var previews: some View {
        MangaPreview(image: UIImage(named: "manga")!.jpegData(compressionQuality: 1.0)!)
    }
}
