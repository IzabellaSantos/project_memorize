//
//  ContentView.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 09/05/22.
 
import SwiftUI
 
struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame //@ObservedObject tells the view that when the model changes, the view has to rebuild
    
    var body: some View {
        let themeColor: Color = viewModel.returnColor()
        
        VStack{
            Text("Score: " + String(viewModel.score)).font(.largeTitle).foregroundColor(.blue)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }.foregroundColor(themeColor)
            }
            
            Spacer()
                        
            HStack{
                newGame
                Spacer()
                Text(viewModel.returnThemeName()).font(.title2).foregroundColor(themeColor)
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    var newGame: some View{
        Button {
            viewModel.newGame()
        } label: {
            VStack{
                Image(systemName: "arrowtriangle.right.circle")
                Text("Game")
                    .font(.caption)
            }
        }
    }
}
 
struct CardView: View{
    let card: MemoryGame<String>.Card
    
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if card.isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched{
                shape.opacity(0)
            }else {
                shape.fill()
            }
        }
        
    
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game).preferredColorScheme(.dark)
    }
}

