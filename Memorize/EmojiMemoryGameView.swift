//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 09/05/22.
 
import SwiftUI
 
struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame //@ObservedObject tells the view that when the model changes, the view has to rebuild

    var body: some View {
        VStack {
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                cardView(for: card)
            }).foregroundColor(game.theme.color)

            Text("Score: \(game.score)").font(.title2)
        }
        .accentColor(game.theme.color)
        .padding()
        .navigationBarTitle(Text(game.theme.name), displayMode: .large)
        .navigationBarItems(trailing: restart)
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

    var restart: some View {
        Button {
            game.newGame()
        } label: {
            VStack {
                Text("Restart")
                    .font(.headline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        return NavigationView {
            EmojiMemoryGameView(game: game)
        }
    }
}

