//
//  FullScreenView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/26/20.
//

import SwiftUI

struct FullScreenView: View {
    let image: UIImage
    
    var body: some View {
        ScrollView {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        }
    }
}

struct FullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenView(image: UIImage(named: "manga")!)
    }
}
