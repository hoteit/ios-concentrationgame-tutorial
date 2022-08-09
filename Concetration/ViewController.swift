//
//  ViewController.swift
//  Concetration
//
//  Created by Tarek Hoteit on 2/8/19.
//  Copyright © 2019 Tarek Hoteit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberofPairsofCards: (cardButtons.count + 1) / 2)
    

    @IBAction func startNewGame(_ sender: UIButton) {
        game = Concentration(numberofPairsofCards: (cardButtons.count + 1) / 2)
        emojiThemes = addNewTheme(themeName: "test", themeEmojis: ["x","a","s","d","r","w","g"])
        updateViewFromModel()
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = [ "🎃", "👻", "🐱", "🐹", "🐥", "🐝", "🐠", "🐳", "🦈", "🦂"]
    var emojiThemes : [String: [String]] = ["animals": ["🐶", "🐱", "🐭", "🐮", "🙊", "🐥", "🦋", "🐦", "🐺"],
                       "sports": ["⚽️", "⚾️", "🎾", "🏐", "🎱", "🏓", "⛸", "🏉", "⛳️", "🥋"],
                       "faces": ["😀", "😳", "😤", "😡", "🥰", "😜", "😭", "😇", "🤬", "😱"],
                       "flags": ["🇱🇧", "🇯🇴", "🇮🇹", "🎌", "🇩🇿", "🇫🇮", "🇲🇨", "🇺🇸", "🇺🇾", "🇰🇷"],
                       "objects": ["🕹", "💿", "📟", "📡", "📱", "☎️", "🌡", "✂️", "🔑", "🛎"],
                       "travel": ["🛥", "🗿", "🏛", "🕌", "🏯", "🏖", "🏭", "⛺️", "🎢", "🕍"]]
    

    var emoji = [Int: String]()
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.lastIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print ("card number \(cardNumber)")
        } else {
            print ("card is not in the list of cards")
        }
    }
    
    func addNewTheme(themeName: String, themeEmojis: [String]) -> [String: [String]] {
        if !themeName.isEmpty, !themeEmojis.isEmpty, emojiThemes[themeName] == nil {
            emojiThemes[themeName] = themeEmojis
        } else {
            print ("The key \(themeName) already exists")
        }
        return emojiThemes
    }
   
    
    
    func updateViewFromModel() {
        // pick random theme

        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        gameScoreLabel.text = "Score: \(game.gameScore)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, !emojiThemes.isEmpty  {
            // pick a theme
            let emojiThemesAvailable = Array(emojiThemes.keys)
            let anEmojiTheme  = emojiThemesAvailable[Int(arc4random_uniform(UInt32(emojiThemesAvailable.count)))]
            if var aMojisSelection = emojiThemes[anEmojiTheme] {
                let randomIndex  = Int(arc4random_uniform(UInt32(aMojisSelection.count)))
                emoji[card.identifier] = aMojisSelection.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier]  ?? "?"
    }
}

