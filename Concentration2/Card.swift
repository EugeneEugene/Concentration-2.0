//
//  Card.swift
//  Concentration2
//
//  Created by eugene on 13/12/2017.
//  Copyright © 2017 monkey_head. All rights reserved.
//

import Foundation

struct Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false;
    var isMatched = false;
    private(set) var identifier: Int;
    var isSeen = false;
    
    static var identifierFactory = 0;
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
