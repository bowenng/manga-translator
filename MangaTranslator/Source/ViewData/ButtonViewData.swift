//
//  ContextMenuButtonViewData.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/27/20.
//

import Foundation

struct ButtonViewData: Identifiable {
    let title: String?
    let iconSystemName: String
    let action: () -> Void
    let type: ActionType
    var id = UUID()
    
    enum ActionType {
        case destructive
        case `default`
        case cancel
    }
    
    init(title: String? = nil, iconSystemName: String, action: @escaping () -> Void, type: ActionType = .default) {
        self.title = title
        self.iconSystemName = iconSystemName
        self.action = action
        self.type = type
    }
}

extension ButtonViewData: Hashable {
    static func == (lhs: ButtonViewData, rhs: ButtonViewData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(iconSystemName)
    }
}
