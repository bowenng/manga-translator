//
//  FloatingButton.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/28/20.
//

import SwiftUI

struct FloatingButton: View {
    let viewData: ButtonViewData
    
    var body: some View {
        Button(action: viewData.action) {
            HStack {
                Image(systemName: viewData.iconSystemName)
                    .font(.title)
                if let title = viewData.title {
                    Text(title)
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)
            .shadow(radius: 3.0)
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(viewData: ButtonViewData(title: "Button", iconSystemName: "printer", action: {}, type: .default))
                .previewLayout(.fixed(width: 200, height: 100))
    }
}
