//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 03.05.2023.
//

import Foundation


class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"]
    
    private static func createMemoryGame()->MemoryGame<String>  {
        MemoryGame<String>(numberOfPairsOfCards: 4) { index in EmojiMemoryGame.emojis[index] }
    }
    
   @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card){
       model.choose(card)
    }
    
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = EmojiMemoryGame.createMemoryGame()
    }
}
