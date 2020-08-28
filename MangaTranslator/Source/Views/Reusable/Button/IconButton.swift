//
//  IconButton.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/28/20.
//

import SwiftUI

struct IconButton: View {
    let viewData: ButtonViewData
    
    var body: some View {
        Button(action: viewData.action) {
            HStack {
                Image(systemName: viewData.iconSystemName)
                    .font(.title)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 5)
            .foregroundColor(.black)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(viewData: ButtonViewData(iconSystemName: "printer", action: {}, type: .default))
    }
}
