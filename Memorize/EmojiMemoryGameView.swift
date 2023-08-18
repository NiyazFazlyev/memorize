//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 02.05.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    
    var body: some View  {
        ZStack {
            VStack{
                gameBody
                    HStack {
                        restart
                        Spacer()
                        shuffle
                    }
                    .padding()
                }
            deckBody

        }
        
        .padding(.horizontal)
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: MemoryGame<String>.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: MemoryGame<String>.Card) -> Bool{
        !dealt.contains(card.id)
    }
    
    var deckBody: some View {
        ZStack{
            ForEach(game.cards.filter(isUndealt)){card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(card: card))
            }
            .frame(width: 60, height: 90)
            .foregroundColor(.red)
            
            .onTapGesture {
                for card in game.cards {
                    withAnimation(dealAnimation(card: card)){
                        deal(card)
                    }
                }
               
            }
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .onTapGesture {
                    withAnimation() {
                        game.choose(card)
                    }
                }
                .transition(AnyTransition.asymmetric(
                    insertion: .scale,
                    removal: .identity)
                )
                .zIndex(zIndex(card: card))
            }
 
        }
        .foregroundColor(.red)
    }
    
    var restart: some View {
        Button("Restart"){
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle"){
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    
    
    private func dealAnimation(card: MemoryGame<String>.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}){
            delay = Double(index) * (2/Double(game.cards.count))
        }
        return Animation.easeOut(duration: 0.5).delay(delay)
    }
    
    private func zIndex(card: MemoryGame<String>.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
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
