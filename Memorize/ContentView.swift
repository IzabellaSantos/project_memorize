//
//  ContentView.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 09/05/22.
 
import SwiftUI
 
struct ContentView: View {
    @State var emojis = ["✈️", "🚀", "🚲", "🚁", "🚗", "🚕", "🚎", "🛴", "🚝", "🛶"]
    
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100
                                                      ))]){
                    ForEach(emojis[0..<emojis.count], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }.foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
            
            HStack{
                themeHealth
                Spacer()
                themeTransportation
                Spacer()
                themeAnimals
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.horizontal)
    
    }
    
    var themeHealth: some View{
        Button {
            emojis = ["💊", "🌡", "🦠", "🩹", "💉", "🧬", "🩺", "🏨"]
            emojis.shuffle()
        } label: {
            VStack{
                Image(systemName: "staroflife.circle")
                Text("Saúde")
                    .font(.caption)
            }
        }
    }
    
    var themeTransportation: some View{
        Button {
            emojis = ["✈️", "🚀", "🚲", "🚁", "🚗", "🚕", "🚎", "🛴", "🚝", "🛶"]
            emojis.shuffle()
        } label: {
            VStack{
                Image(systemName: "tram.circle")
                Text("Veículos")
                    .font(.caption)
            }
            
        }
    }
    
    var themeAnimals: some View{
        Button {
            emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐯", "🦁", "🐷", "🐮"]
            emojis.shuffle()
        } label: {
            VStack{
                Image(systemName: "pawprint.circle")
                Text("Animais")
                    .font(.caption)
            }
        }
    }
    
}
 
struct CardView: View{
    var content: String
    @State var isFaceUp: Bool = true //default value in a pointer (bc of the state)
    
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        
        //onclick
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

