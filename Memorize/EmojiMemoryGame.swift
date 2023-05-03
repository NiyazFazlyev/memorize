//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 03.05.2023.
//

import Foundation


class EmojiMemoryGame {
    static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"]
    
    static func createMemoryGame()->MemoryGame<String>  {
        MemoryGame<String>(numberOfPairsOfCards: 4) { index in EmojiMemoryGame.emojis[index] }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
}
