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
            CardView(card).padding(4)
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
 
struct CardView: View {
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(5).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 25
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
    }
}

