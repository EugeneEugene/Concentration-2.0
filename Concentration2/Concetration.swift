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
    
    var indexOfOneAndOnlyFaceUp: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func choseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                if (cards[matchIndex] == cards[index]) {
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
            }
            else {
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
