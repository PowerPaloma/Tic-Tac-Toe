//
//  MenuGame.swift
//  Tic-Tac-Toe
//
//  Created by Paloma Bispo on 22/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import SpriteKit

class MenuGame: SKScene {

    var playButton = SKSpriteNode()
    var settingsButton = SKSpriteNode()
    private let playButtonTex = SKTexture(imageNamed: "play")
    private let settingsButtonTex = SKTexture(imageNamed: "settings")
    
    override func didMove(to view: SKView) {
        initialSetup()
        addChilds()
        constraintsSetup()
    }
    
    private func addChilds(){
        addChild(playButton)
        addChild(settingsButton)
    }
    
    private func constraintsSetup(){
        //constraints in playButton
        let height = playButton.frame.height
        playButton.position = CGPoint(x: frame.midX, y: frame.midY + height/2)
        //constraints in settingButton
        settingsButton.position = CGPoint(x: frame.midX, y: playButton.frame.minY-height)
    }
    
    private func initialSetup(){
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playButton = SKSpriteNode(texture: playButtonTex)
        settingsButton = SKSpriteNode(texture: settingsButtonTex)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let playTouch = touches.first {
            let position = playTouch.location(in: self)
            guard let node = self.nodes(at: position).first, let size = view?.bounds.size else {return}
            if node == playButton {
                let game = GameScene.init(size: size) 
                game.scaleMode = .resizeFill
                self.view?.presentScene(game)
            }else if node == settingsButton {
                
            }
        }
    }
}
