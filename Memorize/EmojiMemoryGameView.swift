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
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            cardView(for: card)
        }
        .onAppear {
            withAnimation {
                for card in game.cards {
                    deal(card)
                }
            }
        }
        .foregroundColor(themeColor)

        Spacer()
                        
        HStack {
            newGame
            Spacer()
            Text(game.returnThemeName()).font(.title2).foregroundColor(themeColor)
        }
        .padding(.horizontal)
        .font(.largeTitle)
    }
    
    @State private var dealt = Set<Int>()
        
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if (isUndealt(card)) || card.isMatched && !card.isFaceUp {
            Color.clear
        } else {
            BuildCard(card)
            .padding(4)
            .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    game.choose(card)
                }
            }
        }
    }
    
    var newGame: some View {
        Button {
            withAnimation {
                game.newGame()
            }
        } label: {
            VStack {
                Image(systemName: "arrowtriangle.right.circle")
                Text("Game")
                    .font(.caption)
            }
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                BuildCard(card)
            }
        }
        
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
        .foregroundColor(CardConstants.color)
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealtDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealWidth = undealHeight * aspectRatio
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
    }
}

