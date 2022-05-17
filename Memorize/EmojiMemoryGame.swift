//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 16/05/22.
//  This is de VIEWMODEL

import SwiftUI

class EmojiMemoryCard{
    static let emojis = ["✈️", "🚀", "🚲", "🚁", "🚗", "🚕", "🚎", "🛴", "🚝", "🛶"]
    
    static func createMemoryGame() -> MemoryGame<String>{
         MemoryGame<String>(numberOfPairs: 4) {pairIndex in
             EmojiMemoryCard.emojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String> = EmojiMemoryCard.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
}
