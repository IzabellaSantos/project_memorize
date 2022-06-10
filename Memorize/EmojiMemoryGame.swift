//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 16/05/22.
//  This is de VIEWMODEL

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private var themeNames = ["Animals", "Transportation", "Health", "Fruits", "Electronics", "Tools"]
    private static var themeModel = ThemeModel()
    private static var themeParameters: ThemeModel.Theme = themeModel.chooseTheme(nameTheme: "Transportation")
    
    @Published private var model = EmojiMemoryGame.createMemoryGame() //every time the model changes, @Published will tell the view
    
    var cards: Array<Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    //create the cards
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairs: themeParameters.pairs) {pairIndex in
             EmojiMemoryGame.themeParameters.emojis[pairIndex]
        }
    }
    
    //choose a theme randomly and rebuild the cards
    func newGame() {
        var themeModel = ThemeModel()
        
        themeNames.shuffle()
        EmojiMemoryGame.themeParameters = themeModel.chooseTheme(nameTheme: themeNames[0])
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func returnThemeName() -> String {
        EmojiMemoryGame.themeParameters.name
    }
    
    //calls the logic behind the faceup and match cards
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    //returns the color of the theme for the view
    func returnColor() -> Color {
        switch EmojiMemoryGame.themeParameters.color {
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
