//
//  ContextMenuButton.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/28/20.
//

import SwiftUI

struct ContextMenuButton: View {
    let viewData: ContextMenuButtonViewData
    var body: some View {
        Button(action: viewData.action) {
            HStack {
                Image(systemName: viewData.iconSystemName)
                Text(viewData.title)
            }
        }
    }
}

struct ContextMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuButton(viewData: ContextMenuButtonViewData(title: "Delete",
                                                              iconSystemName: "trash",
                                                              action: {},
                                                              type: .default))
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
