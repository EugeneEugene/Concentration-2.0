//
//  Concetration.swift
//  Concentration2
//
//  Created by eugene on 13/12/2017.
//  Copyright © 2017 monkey_head. All rights reserved.
//

import Foundation

internal class Concentration {
    var cards = [Card]()
    
    var flipCount = 0 
    
    var indexOfOneAndOnlyFaceUp: Int?
    
    func choseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                if (cards[matchIndex].identifier == cards[index].identifier) {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = nil
            }
            else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = index
            }
        }
    }
    
    func startNewGame() {
        flipCount = 0;
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    init(numberOfPairsOfcards: Int) {
        for _ in 1...numberOfPairsOfcards {
            let card = Card()
            cards += [card, card]
        }
    }
}
