//
//  Card.swift
//  Concentration2
//
//  Created by eugene on 13/12/2017.
//  Copyright © 2017 monkey_head. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false;
    var isMatched = false;
    var identifier: Int;
    var isSeen = false;
    
    static var identifierFactory = 0;
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
