//
//  Board.swift
//  Tic-Tac-Toe
//
//  Created by Paloma Bispo on 19/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import GameplayKit

class Board: NSObject, GKGameModel {
    
    var currentPlayer: Player = Player.allPlayers[arc4random() % 2 == 0 ? 0 : 1]
    var n: Int
    private var boardValues: [[Player.Value]]
    
    subscript(row: Int, col: Int) -> Player.Value {
        get {
           return boardValues[row][col]
        }
        set{
            if boardValues[row][col] == .empty{
                boardValues[row][col] = newValue
            }
        }
    }
    
    var isFull: Bool {
        for row in boardValues {
            for col in row {
                if col == .empty{
                    return false
                }
            }
        }
        return true
    }
    
    var winningPlayer: Player? {
        var check = boardValues
        for row in 0...boardValues.count{
            for col in 0...boardValues[0].count {
                if
            }
        }
    }
    
    convenience init(n: Int) {
        self.n = n
        custonInit()
    
    }
    
    func custonInit(){
        for i in 0...n{
            boardValues.append([])
            for _ in 0...n {
                boardValues[i].append(.empty)
            }
        }
    }
    
    private func hasWinner(in vector : [Player.Value]) -> (hasWinner: Bool, player: Player?){
        let aux = vector[0]
        if aux == .empty {
            return (false, nil)
        }
        for i in 1...vector.count {
            if vector[i] != aux {
                return (false, nil)
            }
        }
        
        return (true, nil)
    }
    
    // MARK: - NSCoping
    
    //GKGameModel requires conformance to NSCopying because the strategist evaluates moves against copies of the game
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board()
        copy.setGameModel(self)
        return copy
    }
    
    // MARK: -GKGameModel
    var activePlayer: GKGameModelPlayer?{
        return currentPlayer
    }
    
    var players: [GKGameModelPlayer]?{
        return Player.allPlayers()
    }
    
    //lets GameplayKit update your game model with the new state after it makes a decision.
    func setGameModel(_ gameModel: GKGameModel) {
        <#code#>
    }
    
    func isWin(for player: GKGameModelPlayer) -> Bool{
        
        
        
    }
    
    
    

}
