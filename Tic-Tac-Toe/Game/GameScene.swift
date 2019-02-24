//
//  GameScene.swift
//  Tic-Tac-Toe
//
//  Created by Paloma Bispo on 19/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var boardNode: SKSpriteNode!
    var headerNode: SKSpriteNode!
    var informationLabel: SKLabelNode!
    var gamePieceNodes: [[SKSpriteNode]] = []
    var strategist: Strategist!
    var board = Board(n: 3)
    private var n = 3
    private var lastUpdateTime : TimeInterval = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = SKColor.white
        startGame()
        addChilds()
        
        
    }
    
    private func addChilds(){
        addChild(boardNode)
        addChild(headerNode)
        addChild(informationLabel)
    }
    
    private func startGame(){
        //board setup
        let nameTex = n == 3 ? "board3" : "board4"
        let boardTex = SKTexture(imageNamed: nameTex)
        guard let viewFrame = view?.frame else {return}
        let widthBoard = viewFrame.width - 24
        boardNode = SKSpriteNode(texture: boardTex, size: CGSize(width: widthBoard, height: widthBoard))
        boardNode.position = CGPoint(x: 0.0, y: 0.0)
        
        //header setup
        headerNode = SKSpriteNode(color: UIColor.lightGray, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.14))
        headerNode.anchorPoint = CGPoint(x: 0.0, y: 1)
        headerNode.position.x = -viewFrame.maxX/2
        headerNode.position.y = -(viewFrame.maxY/2 - headerNode.frame.height)
        print(headerNode.position.y)
        
        //informationLabel setup
        informationLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        informationLabel.fontSize = 40
        informationLabel.fontColor = .black
        informationLabel.position = CGPoint(x: headerNode.frame.midX, y: headerNode.frame.midY)
        informationLabel.verticalAlignmentMode = .center
        
        let cellWidth = boardNode.frame.width/CGFloat(n)
        print("cellWidth", cellWidth)
        for row in 0...(n-1){
            gamePieceNodes.append([])
            for col in 0...(n-1){
                gamePieceNodes[row].append(SKSpriteNode())
                let x = boardNode.frame.minX + (cellWidth * CGFloat(col))
                let y = boardNode.frame.maxY - (cellWidth * CGFloat(row))
                let rect = CGRect(x: x, y: y, width: cellWidth, height: cellWidth)
                let piece = SKSpriteNode(color: UIColor.clear, size: rect.size)
                piece.anchorPoint = CGPoint(x: 0.0, y: 1.0)
                piece.position = rect.origin
                gamePieceNodes[row][col] = piece
            }
        }
        board.currentPlayer = Player.allPlayers[arc4random() % 2 == 0 ? 0 : 1]
        informationLabel.text = "\(board.currentPlayer.name)'s Turn"
    }
    
    private func resetGame(){
       board = Board(n: 3)
    }
    
    private func updateGame(){
        var gameOver = ""
        if board.isFull {
            gameOver = "draw"
        }else if let winner = board.winningPlayer, winner == board.currentPlayer {
            gameOver = "\(board.currentPlayer.name) wins"
        }
        if gameOver != ""{
            let alertGameOver = UIAlertController(title: gameOver, message: nil, preferredStyle: UIAlertController.Style.alert)
            self.view?.window?.rootViewController?.present(alertGameOver, animated: true, completion: nil)
        }else{
            informationLabel.text = "\(board.currentPlayer.name)'s Turn"
            board.currentPlayer = board.currentPlayer.opponent
        }
    }
    
    private func updateBoard(x: Int, y: Int){
        if board[x, y] != .empty { return }
        board[x, y] = board.currentPlayer.value
        let node = gamePieceNodes[x][y]
        let nodePosition = node.position
        let nodeImageName = board.currentPlayer.name == "X" ? "x" : "o"
        let nodeWidth = node.frame.width - 20
        node.texture = SKTexture(imageNamed: nodeImageName)
        node.size = CGSize(width: nodeWidth/2, height: nodeWidth/2)
        node.position = CGPoint(x: nodePosition.x+10, y: nodePosition.y-10)
        node.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        node.run(SKAction.scale(by: 2, duration: 0.25))
        self.addChild(node)
        updateGame()
    }
    
    private func handle(touch: UITouch){
        var piece: SKNode!
        for row in 0...(n-1){
            for col in 0...(n-1){
                piece = gamePieceNodes[row][col]
                if piece.frame.contains(touch.location(in: boardNode)){
                    updateBoard(x: row, y: col)
                    return
                }
            }
        }
        
//        for piece in boardNode.children{
//            if touch.location(in: boardNode) == piece.frame.origin {
//                print(piece.textInputContextIdentifier)
//            }
//        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let possition = touch.location(in: self)
            guard let node = self.nodes(at: possition).first else {return}
            if node == boardNode{
                handle(touch: touch)
            }
            
        }
        
    }
}
