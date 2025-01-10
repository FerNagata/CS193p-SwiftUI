//
//  ContentView.swift
//  Memorize
//
//  Created by Fernanda Nagata Ito on 16/12/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    
    @State var cardCount: Int = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardCountAjusters
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)

    }
    
    var cardCountAjusters: some View{
        HStack{
            cardRemover
            Spacer()
            cardAdder            }
        .imageScale(.large)
        .font(.largeTitle)

    }
    
    func cardCountAjuster(by offset: Int, symbol: String) -> some View{
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)

    }
    var cardRemover: some View{
        cardCountAjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var cardAdder: some View{
        cardCountAjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

#Preview {
    ContentView()
}

struct CardView: View { // obs: View are immutable
    let content: String
    @State var isFaceUp = true // @state - create a pointer
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}
