//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 09/05/22.
 
import SwiftUI
 
struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame //@ObservedObject tells the view that when the model changes, the view has to rebuild
    
    var body: some View {
        let themeColor: Color = game.returnColor()
        
        Text("Score: " + String(game.score)).font(.largeTitle).foregroundColor(.blue)
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            cardView(for: card)
        }).foregroundColor(themeColor)

        Spacer()
                        
        HStack {
            newGame
            Spacer()
            Text(game.returnThemeName()).font(.title2).foregroundColor(themeColor)
        }
        .padding(.horizontal)
        .font(.largeTitle)

        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            BuildCard(card).padding(4)
            .onTapGesture {
                game.choose(card)
            }
        }
    }
    
    var newGame: some View {
        Button {
            game.newGame()
        } label: {
            VStack {
                Image(systemName: "arrowtriangle.right.circle")
                Text("Game")
                    .font(.caption)
            }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
    }
}

