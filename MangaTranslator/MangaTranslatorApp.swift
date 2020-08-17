//
//  MangaTranslatorApp.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/16/20.
//

import SwiftUI

@main
struct MangaTranslatorApp: App {
    var body: some Scene {
        WindowGroup {
            MangaPicker(translator: OfflineTranslator())
        }
    }
}
