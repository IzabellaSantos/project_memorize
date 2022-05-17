//
//  MemoryGame.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 17/05/22.
//  This is the MODEL

import Foundation

struct MemoryGame<CardContent>{
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card){
        
    }
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairs {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card{
        var isFacedUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
