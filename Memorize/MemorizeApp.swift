//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 02.05.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
