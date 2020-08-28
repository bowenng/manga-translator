//
//  ContextMenuButtonViewData.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/27/20.
//

import Foundation

struct ContextMenuButtonViewData: Identifiable {
    let title: String
    let iconSystemName: String
    let action: () -> Void
    let type: ActionType
    var id = UUID()
    
    enum ActionType {
        case destructive
        case `default`
        case cancel
    }
}

extension ContextMenuButtonViewData: Hashable {
    static func == (lhs: ContextMenuButtonViewData, rhs: ContextMenuButtonViewData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(iconSystemName)
    }
}
