//
//  Page.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/20/20.
//

import Foundation
import UIKit

struct Page: Codable, Identifiable {
    let image: Data
    let createdTimeStamp: Date
    
    var id = UUID()
}

extension Page : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(createdTimeStamp)
    }
}

extension Page: Viewable {
    var preview: UIImage {
        return UIImage(data: image)!
    }
}
