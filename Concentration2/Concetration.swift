//
//  Concetration.swift
//  Concentration2
//
//  Created by eugene on 13/12/2017.
//  Copyright © 2017 monkey_head. All rights reserved.
//

import Foundation
import GameplayKit

internal class Concentration {
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    private(set) var score = 0;
    
    var indexOfOneAndOnlyFaceUp: Int?
    
    func choseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                if (cards[matchIndex].identifier == cards[index].identifier) {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 1
                }
                else {
                    if(cards[index].isSeen) {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                cards[index].isSeen = true
                indexOfOneAndOnlyFaceUp = nil
            }
            else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                cards[index].isFaceUp = true
                cards[index].isSeen = true
                indexOfOneAndOnlyFaceUp = index
            }
        }
    }
        
    init(numberOfPairsOfcards: Int) {
        for _ in 1...numberOfPairsOfcards {
            let card = Card()
            cards += [card, card]
        }
        cards = (GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card])
    }
}
