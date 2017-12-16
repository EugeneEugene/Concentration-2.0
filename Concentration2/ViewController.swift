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
    @IBOutlet var cardsArray: [UIButton]!
    let themeArray =
        [
        ["👮‍♂️","👩🏽‍🍳","👲🏻","🧒🏿","👴🏻","👩🏼‍🌾","👶🏻","🎅🏼","👨🏿‍🚒","👳🏿‍♀️","🕵🏻‍♀️","👩🏻‍🎨","🧝🏿‍♀️","👩🏿‍💻","👨‍💻","👩‍🎤"],
        ["🧛🏼‍♂️","🧟‍♂️","🧠","👻","💀","☠️","🤖","🎃","👹","👽","🤡","🤐","😱","🕸","🌚", "🧙🏾‍♂️"],
        ["⚽️","🏀","🏈","⚾️","🎾","🏐", "🎱", "🏉","🏓","🏸","🥅","🏒","🏑","🏏","⛳️","🏹"],
        ["🚗","🚕","🚙","🚌","🚎","🏎", "🚓", "🚑","🚒","🛴","🚲","🛵","🏍","🚔","✈️","🛫"],
        ["🏳️","🏴","🏳️‍🌈","🇦🇫","🇦🇽","🇦🇱", "🇦🇷", "🇦🇬","🇦🇶","🇦🇮","🇦🇴","🇦🇩","🇦🇸","🇩🇿","🇦🇲","🇧🇧"],
        ["💟","☮️","✝️","☪️","🕉","☸️","✡️", "🔯","🕎"," ☯️","☦️","🛐","⛎","♈️","♉️","♊️"],
    ]
    
    let colorFotTheme = [#colorLiteral(red: 0.9940492511, green: 0.8414244056, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
    var emojiArray: Array<String> = []
    var emoji = [Int: String]()
    var themeId = 0;
    var faceDownColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    func randomChoseTheme() {
        emojiArray.removeAll()
        themeId = Int(arc4random_uniform(UInt32(themeArray.count)))
        faceDownColor = colorFotTheme[themeId]
        emojiArray += themeArray[themeId]
        
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiArray.count > 0 {
            let randomEmoji = Int(arc4random_uniform(UInt32(emojiArray.count)))
            emoji[card.identifier] = emojiArray.remove(at: randomEmoji)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBOutlet weak var flipCountView: UITextField!
   
    @IBOutlet weak var scoreView: UITextField!
    //start new game
    @IBAction func newGameView(_ sender: UIButton) {
        randomChoseTheme()
        game = Concentration(numberOfPairsOfcards: (cardsArray.count + 1)/2)
        emoji = [Int: String]()
        updateViewFromModel()
    }
    
    

    @IBAction func touchCard(_ sender: UIButton) {
        print("Count of themes: \(themeArray.count)")
        if let chosenCard = cardsArray.index(of: sender) {
            game.choseCard(at: chosenCard)
            updateViewFromModel();
        }
        else {
            print("Choose is not in card buttons!")
        }
    }
    
    func updateViewFromModel() {
        flipCountView.text = "Flips: \(game.flipCount)"
        scoreView.text = "Score: \(game.score)"
        for index in cardsArray.indices {
            let card = game.cards[index]
            let button = cardsArray[index]
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControlState.normal)
            }
            else {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : faceDownColor
                button.setTitle("", for: UIControlState.normal)
            }
        }
    }
    
    
    
}

