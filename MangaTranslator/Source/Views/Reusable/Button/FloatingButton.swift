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
            .disabled(viewData.isDisabled)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .foregroundColor(viewData.foregroundColor)
            .background(viewData.backgroundColor)
            .opacity(viewData.isDisabled ? 0.4 : 1.0)
            .cornerRadius(10)
            .shadow(radius: 3.0)
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FloatingButton(viewData: ButtonViewData(title: "Button", iconSystemName: "printer", action: {}, type: .default))
            FloatingButton(viewData: ButtonViewData(title: "Button", iconSystemName: "printer", action: {}, type: .default,isDisabled: true))
        }
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
