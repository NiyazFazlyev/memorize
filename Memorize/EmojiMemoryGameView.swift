//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 02.05.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
   @ObservedObject var game: EmojiMemoryGame
    
    
    var body: some View  {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
            
        }
        

        .foregroundColor(.red)
        .padding(.horizontal)
    }
}







struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack {
                  Pie(
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: -180 )
                    ).padding(4).opacity(0.5)
                    Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0 ))
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
        }
        
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: DrawingConstants.fontScale * min(size.height, size.width))
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.height, size.width) / DrawingConstants.fontSize * DrawingConstants.fontScale
    }

    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}























struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return  EmojiMemoryGameView(game: game)
            
    }
}
