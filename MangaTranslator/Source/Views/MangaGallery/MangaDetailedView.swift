//
//  MangaDetailedView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import SwiftUI

struct MangaDetailedView: View {
    let image: Data
    
    var body: some View {
        ScrollView {
            Image(uiImage: UIImage(data: image)!)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        }
    }
}

struct MangaDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        MangaDetailedView(image: UIImage(named: "manga")!.jpegData(compressionQuality: 1.0)!)
    }
}
