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
            Main(shelf: Shelf())
        }
    }
}

struct MangaTranslatorApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
