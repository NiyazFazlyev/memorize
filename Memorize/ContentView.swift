//
//  ContentView.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 02.05.2023.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"]

   
   @State var emojiCount = 5
    
    var body: some View  {
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(emojis[0..<emojiCount], id: \.self) {emoji in
                        CardView(content: emoji)
                    }
                    
                }
            }
            .foregroundColor(.red)
            Spacer(minLength: 20)
            HStack {
               remove
               Spacer ()
               add
            }
           .font(.largeTitle)
           .padding(.horizontal)

        }
        .padding()
    }
    
    var remove: some View  {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
         } label: {
             Image(systemName: "minus.circle")
             
         }
    }
    
    var add: some View  {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
         } label: {
             Image(systemName: "plus.circle")
         }
    }
}






struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius:25)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }.aspectRatio(2/3, contentMode: .fit)
    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone SE (3rd generation)")
    }
}
