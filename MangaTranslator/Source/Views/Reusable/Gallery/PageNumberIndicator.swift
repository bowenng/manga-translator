//
//  PageNumberIndicator.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/30/20.
//

import SwiftUI

struct PageNumberIndicator: View {
    let pageNumber: Int
    let totalNumberOfPages: Int
    
    var body: some View {
        Text("\(pageNumber)/\(totalNumberOfPages)")
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.gray)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            .opacity(0.4))
    }
}

struct PageNumberIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PageNumberIndicator(pageNumber: 1, totalNumberOfPages: 10)
    }
}
