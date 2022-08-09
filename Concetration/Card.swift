//
//  Card.swift
//  Concetration
//
//  Created by Tarek Hoteit on 2/11/19.
//  Copyright © 2019 Tarek Hoteit. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    // it does not need emoji this is part of how it displays and not in model

    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }
}
