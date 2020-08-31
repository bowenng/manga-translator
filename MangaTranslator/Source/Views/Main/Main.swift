//
//  MainView.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/30/20.
//

import SwiftUI

struct Main: View {
    @ObservedObject var shelf: Shelf
    
    var body: some View {
        TabView {
            Translation(shelf: shelf)
                .tabItem {
                    Image(systemName: "translate")
                    Text("Translate")
                }
            
            ShelfView(shelf: shelf)
                .tabItem {
                    Image(systemName: "book")
                    Text("Library")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Main(shelf: Shelf())
    }
}
