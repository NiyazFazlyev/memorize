//
//  ContentView.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 02.05.2023.
//

import SwiftUI

struct ContentView: View {
    
   @ObservedObject var viewModel: EmojiMemoryGame
    
    
    var body: some View  {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                ForEach(viewModel.cards) {card in
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}






struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius:20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.headline)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
        .aspectRatio(2/3, contentMode: .fill)

        
    }
}





















struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            
    }
}
