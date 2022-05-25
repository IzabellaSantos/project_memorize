//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 16/05/22.
//  This is de VIEWMODEL

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    
    var themeNames = ["Animals", "Transportation", "Health", "Fruits", "Electronics", "Tools"]
    static var themeModel: ThemeModel = ThemeModel()
    static var themeParameters: ThemeModel.Theme = themeModel.chooseTheme(nameTheme: "Transportation")
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame() //every time the model changes, @Published will tell the view
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    var score: Int{
        model.score
    }
    
    //choose a theme randomly and rebuild the cards
    func newGame(){
        var themeModel: ThemeModel = ThemeModel()
        
        themeNames.shuffle()
        EmojiMemoryGame.themeParameters = themeModel.chooseTheme(nameTheme: themeNames[0])
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func returnThemeName() -> String{
        EmojiMemoryGame.themeParameters.name
    }
    
    //create the cards
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame<String>(numberOfPairs: themeParameters.pairs) {pairIndex in
             EmojiMemoryGame.themeParameters.emojis[pairIndex]
        }
    }
    
    //calls the logic behind the faceup and match cards
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    //returns the color of the theme for the view
    func returnColor() -> Color{
        switch EmojiMemoryGame.themeParameters.color{
            case "blue":
                return Color.blue
            
            case "red":
                return Color.red
                
            case "yellow":
                return Color.yellow
                
            case "pink":
                return Color.pink
            
            case "orange":
                return Color.orange
            
            case "green":
                return Color.green
            
            default:
                return Color.white
        }
    }
}
