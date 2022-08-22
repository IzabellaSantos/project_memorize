//
//  MemoryGame.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 17/05/22.
//  This is the MODEL

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable	{
    private(set) var cards: Array<Card>
    private var indexFirstFaceUp: Int? {
        get { cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue)}) }
    }
    private(set) var score: Int
    
    //mutating - necessary when you try to change any state contained within the struct/enum (Card)
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexFirstFaceUp {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 3
                }
                cards[chosenIndex].isFaceUp = true
                score -= 1
            } else {
                indexFirstFaceUp = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
        score = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int //can be any type you want
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1{
            return first
        }else{
            return nil
        }
    }
}
