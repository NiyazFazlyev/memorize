//
//  ContentView.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 02.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojiCount = 20
    
 
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
        }
        .padding(.horizontal)
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
            
    }
}
