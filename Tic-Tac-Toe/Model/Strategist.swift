//
//  Stategist.swift
//  Tic-Tac-Toe
//
//  Created by Paloma Bispo on 21/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import GameplayKit

struct Strategist {
    
    private let strategist: GKMinmaxStrategist = {
        let strategist = GKMinmaxStrategist()
        
        strategist.maxLookAheadDepth = 5
        strategist.randomSource = GKARC4RandomSource()
        
        return strategist
    }()
    
    var board: Board {
        didSet {
            strategist.gameModel = board
        }
    }
    
    var bestCoordinate: CGPoint? {
        if let move = strategist.bestMove(for: board.currentPlayer) as? Move {
            return move.coordinate
        }
        
        return nil
    }

}
