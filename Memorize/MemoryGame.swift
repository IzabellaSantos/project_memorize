//
//  MemoryGame.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 17/05/22.
//  This is the MODEL

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable	{
    private(set) var cards: Array<Card>
    private var indexFirstFaceUp: Int?
    private(set) var score: Int
    
    //mutating - necessary when you try to change any state contained within the struct/enum (Card)
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexFirstFaceUp{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 3
                }
                indexFirstFaceUp = nil
                score -= 1
            }else{
                for index in cards.indices{
                    cards[index].isFaceUp = false
                }
                indexFirstFaceUp = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairs {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
        score = 0
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int //can be any type you want
    }
}
