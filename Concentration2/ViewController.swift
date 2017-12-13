//
//  ViewController.swift
//  Concentration2
//
//  Created by eugene on 12/12/2017.
//  Copyright © 2017 monkey_head. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfcards: (cardsArray.count + 1)/2)
    
    var flipCount = 0 {
        didSet {
            flipCountView.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet var cardsArray: [UIButton]!
    var emojiArray = ["🧛🏼‍♂️","👄","🧠","👮🏿‍♀️","🛸","🎱", "🌚", "🐖","🐡"]
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiArray.count > 0 {
            let randomEmoji = Int(arc4random_uniform(UInt32(emojiArray.count)))
            emoji[card.identifier] = emojiArray.remove(at: randomEmoji)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBOutlet weak var flipCountView: UITextField!
   
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1;
        if let chosenCard = cardsArray.index(of: sender) {
            game.choseCard(at: chosenCard)
            updateViewFromModel();
        }
        else {
            print("Choose is not in card buttons!")
        }
    }
    
    func updateViewFromModel() {
        for index in cardsArray.indices {
            let card = game.cards[index]
            let button = cardsArray[index]
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControlState.normal)
            }
            else {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle("", for: UIControlState.normal)
            }
        }
    }
    

    
}

