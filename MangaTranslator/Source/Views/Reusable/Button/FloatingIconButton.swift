//
//  FloatingIconButton.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/30/20.
//

import SwiftUI

struct FloatingIconButton: View {
    let viewData: ButtonViewData
    
    var body: some View {
        Button(action: viewData.action) {
            
            Image(systemName: viewData.iconSystemName)
                .font(.title)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 15)
                .background(viewData.backgroundColor)
                .clipShape(Circle())
                .foregroundColor(viewData.foregroundColor)
                .disabled(viewData.isDisabled)
                
        }
    }
}

struct FloatingIconButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingIconButton(viewData: ButtonViewData(iconSystemName: "book", action: {}))
    }
}
