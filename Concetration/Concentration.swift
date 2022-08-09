//
//  Concentration.swift
//  Concetration
//
//  Created by Tarek Hoteit on 2/11/19.
//  Copyright © 2019 Tarek Hoteit. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]() // same as Array<Card>()
    
    var indexofOneandOnlyFacingUpCard: Int?
   
    var gameScore = 0 // game score
    
    var flipCount = 0 // number of flips
    
    func chooseCard(at index:Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexofOneandOnlyFacingUpCard, matchIndex != index {
                //check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                } else {
                    gameScore -= 1
                    if gameScore < 0 {
                        gameScore = 0
                    }
                }
                cards[index].isFaceUp = true
                indexofOneandOnlyFacingUpCard = nil
                flipCount += 1
            } else {
                // either no cards or 2 cards are face up
                for flipDowIndex in cards.indices {
                    cards[flipDowIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexofOneandOnlyFacingUpCard = index
            }
        }
    }
    
    init(numberofPairsofCards: Int) {
        for _ in 1...numberofPairsofCards {
            let card = Card()
            //let match =  card //since card is struct, you can copy)
            cards += [card, card] // or cards.append (card) 2 times
        }
        cards = cards.shuffled()
        // TODO: shuffle the cards
    }
}
