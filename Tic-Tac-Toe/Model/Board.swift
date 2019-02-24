//
//  Board.swift
//  Tic-Tac-Toe
//
//  Created by Paloma Bispo on 19/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import GameplayKit

// GKGameModel - Implement this protocol to describe your gameplay model so that a strategist object can plan game moves.
class Board: NSObject, GKGameModel {
    
    var currentPlayer: Player!
    var n: Int = 0
    var boardValues: [[Player.Value]] = []
    
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
    
    // otimizar essa parte. Verificar apenas a lin, col, dig do novo elemento inserido
    var winningPlayer: Player? {
//        var checkCol: [Player.Value] = []
//        var checkCol: [Player.Value] = []
        var digP: [Player.Value] = []
        var digS: [Player.Value] = []
        var result: (Bool, Player?)
        for row in 0..<boardValues.count{
            result = hasWinner(in: boardValues[row])
            if result.0 {
                guard let winner = result.1 else {return nil}
                return winner
            }
            let col: [Player.Value] = boardValues.reduce(into: []) { (partialResult, array) in
                let value = array[row]
                partialResult.append(value)
            }
            result = hasWinner(in: col)
            if result.0 {
                guard let winner = result.1 else {return nil}
                return winner
            }
            for j in 0..<boardValues[0].count{
                if row == j{
                    digP.append(boardValues[row][j])
                }
                if row == n - 1 - j {
                    digS.append(boardValues[row][j])
                }
            }
        }
        result = hasWinner(in: digS)
        if result.0 {
            guard let winner = result.1 else {return nil}
            return winner
        }
        result = hasWinner(in: digP)
        if result.0 {
            guard let winner = result.1 else {return nil}
            return winner
        }
        return nil
    }
    
    init(n: Int) {
        super.init()
        self.n = n
        self.custonInit()
    }
    
    func custonInit(){
        for i in 0..<n{
            boardValues.append([])
            for _ in 0..<n {
                boardValues[i].append(.empty)
            }
        }
    }
    
    func clear() {
        for row in 0..<boardValues.count{
            for col in 0..<boardValues[row].count{
                self[row, col] = .empty
            }
        }
    }
    
    func score(for player: GKGameModelPlayer) -> Int {
        guard let player = player as? Player else {
            return Move.score.none.rawValue
        }
        
        if isWin(for: player) {
            return Move.score.win.rawValue
        } else {
            return Move.score.none.rawValue
        }
    }
    
    private func hasWinner(in vector : [Player.Value]) -> (hasWinner: Bool, player: Player?){
        let aux = vector[0]
        if aux == .empty {
            return (false, nil)
        }
        for i in 1..<vector.count {
            if vector[i] != aux {
                return (false, nil)
            }
        }
        guard let index = Player.allPlayers.index(where: { player -> Bool in
            return player.value == aux
        }) else {return (false, nil)}
        return (true, Player.allPlayers[index])
    }
    
    // MARK: - NSCoping
    
    //GKGameModel requires conformance to NSCopying because the strategist evaluates moves against copies of the game
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board(n: self.n)
        copy.setGameModel(self)
        return copy
    }
    
    // MARK: -GKGameModel
    var activePlayer: GKGameModelPlayer?{
        return currentPlayer
    }
    
    var players: [GKGameModelPlayer]?{
        return Player.allPlayers
    }
    
    //lets GameplayKit update your game model with the new state after it makes a decision.
    func setGameModel(_ gameModel: GKGameModel) {
        if let board = gameModel as? Board {
            boardValues = board.boardValues
        }
    }
    
    func isWin(for player: GKGameModelPlayer) -> Bool{
        guard let player = player as? Player else {return false}
        if let winner = self.winningPlayer {
            return winner == player
        }else{
            return false
        }
    }
    
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        var possiblesMoves: [Move] = []
        guard let player = player as? Player else {return nil}
        if isWin(for: player) {
            return nil
        }
        for row in 0...boardValues.count{
            for col in 0...boardValues[0].count{
                if boardValues[row][col] == .empty {
                    let move = Move(coordinate: CGPoint(x: row, y: col))
                    possiblesMoves.append(move)
                }
            }
        }
        return possiblesMoves
    }
    
    //GameplayKit calls apply(_:) after each move selected by the strategist so you have the chance to update the game state
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        guard let move = gameModelUpdate as? Move else {return}
        self[Int(move.coordinate.x), Int(move.coordinate.y)] = currentPlayer.value
        currentPlayer = currentPlayer.opponent
    }
}
