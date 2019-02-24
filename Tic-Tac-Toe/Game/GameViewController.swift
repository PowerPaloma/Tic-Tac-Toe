//
//  GameViewController.swift
//  Tic-Tac-Toe
//
//  Created by Paloma Bispo on 19/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let skview = self.view as? SKView {
            let menuScene = MenuGame.init(size: UIScreen.main.bounds.size)
            menuScene.scaleMode = .resizeFill
            menuScene.backgroundColor = SKColor.white
            skview.ignoresSiblingOrder = true
            skview.showsFPS = true
            skview.showsNodeCount = true
            skview.presentScene(menuScene)
        }
    }
        
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
