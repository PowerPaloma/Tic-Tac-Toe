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
    
    var strategist = GKMinmaxStrategist()

    var board: Board {
        didSet {
            strategist.gameModel = board
        }
    }
    
    var bestCoordinate: CGPoint? {
        //getting the best move for the opponent os the current player. In this way, the AI will play for the opponent lose and not for it wins
        if let move = strategist.bestMove(for: board.currentPlayer.opponent) as? Move {
            return move.coordinate
        }
        
        return nil
    }
}
