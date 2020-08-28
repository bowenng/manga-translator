//
//  ContextMenuButtonViewData.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/27/20.
//

import Foundation

struct ContextMenuItemViewData: Identifiable {
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

extension ContextMenuItemViewData: Hashable {
    static func == (lhs: ContextMenuItemViewData, rhs: ContextMenuItemViewData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(iconSystemName)
    }
}
