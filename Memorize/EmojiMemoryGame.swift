//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 16/05/22.
//  This is de VIEWMODEL

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private(set) var theme: EmojiMemoryTheme
    @Published private var model: MemoryGame<String> //every time the model changes, @Published will tell the view
    
    var cards: Array<Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    //create the cards
    init(theme: EmojiMemoryTheme? = nil) {
        self.theme = theme ?? EmojiMemoryTheme.themes.randomElement()!
        let emoji = self.theme.emoji.shuffled()
        model = MemoryGame(numberOfPairsOfCards: self.theme.numberOfPairs) { emoji[$0] }
    }
    
    //rebuild the cards
    func newGame() {
        let emoji = theme.emoji.shuffled()
        model = MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { emoji[$0] }
    }
    
    //calls the logic behind the faceup and match cards
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}
