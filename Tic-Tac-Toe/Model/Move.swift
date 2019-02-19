//
//  Move.swift
//  Tic-Tac-Toe
//
//  Created by Paloma Bispo on 19/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import GameplayKit

class Move: NSObject, GKGameModelUpdate {
    
    enum score: Int{
        case none
        case win
    }
    
    var value: Int = 0
    var cordinate: CGPoint
    
    init(cordinate: CGPoint) {
        self.cordinate = cordinate
    }
    

}
