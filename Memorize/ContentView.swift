//
//  ContentView.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 02.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    
   
    
    var emojisSets = [
        ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"],
        ["🐶", "🦊", "🐻", "🐸", "🐌", "🐢", "🐬", "🐜"],
        ["🍏", "🍊", "🍇", "🍌", "🥝", "🥥", "🍓", "🥑"],
    ]


    @State var emojiCount = 8
    
    @State var themeNumber = 0
    
    var emojis: [String]  {
        var  em = emojisSets[themeNumber]
        em.shuffle()
        return em
    }
    
    
    
    var body: some View  {
        VStack{
            Text("Memorize").font(.largeTitle)
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
                vechicles
                Spacer ()
                animals
                Spacer()
                fruits
            }
           .font(.largeTitle)
           .padding(.horizontal)

        }
        .padding()
    }
    
    var vechicles: some View  {
        Button {
            themeNumber = 0
         } label: {
             VStack{
                 Image(systemName: "car")
                 Text("Vehicles")
                     .font(.caption)

             }
         }
    }
    
    var animals: some View  {
        Button {
            themeNumber = 1
         } label: {
             VStack{
                 Image(systemName: "fish")
                 Text("Animals")
                     .font(.caption)

             }
         }
    }
    
    var fruits: some View  {
        Button {
            themeNumber = 2
         } label: {
             VStack{
                 Image(systemName: "apple.logo")
                 Text("Fruits")
                     .font(.caption)

             }
         }
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
            if emojiCount < emojisSets[themeNumber].count {
                emojiCount += 1
            }
         } label: {
             Image(systemName: "plus.circle")
         }
    }
}






struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
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
