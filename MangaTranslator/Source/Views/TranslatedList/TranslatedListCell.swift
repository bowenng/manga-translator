//
//  TranslatedListCell.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import SwiftUI

struct TranslatedListCell: View {
    let thumbnail: UIImage
    let title: String
    let caption: String
    
    var body: some View {
        HStack {
            Image(uiImage: thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 40, maxWidth: 40, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 40, maxHeight: 40, alignment: .center)
                .cornerRadius(8.0)
            VStack (alignment: .leading){
                Text(title)
                    .font(.body)
                Text(caption)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Spacer()
        }.padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct TranslatedListCell_Previews: PreviewProvider {
    static var previews: some View {
        TranslatedListCell(thumbnail: UIImage(systemName: "photo")!,
                           title: "Title", caption: "2019/02/11").previewLayout(.fixed(width: 300, height: 70))
    }
}
