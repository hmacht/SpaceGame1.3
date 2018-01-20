//
//  FinishLine.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/15/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class FinishLine: SKSpriteNode {
    
    convenience init(color: UIColor, size: CGSize) {
        //self.init(color: color, size: size)
        self.init(texture: nil, color: color, size: size)
        
        self.zPosition = 50
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = physicsCatagory.finishLine
        self.physicsBody?.collisionBitMask = physicsCatagory.finishLine 
        self.physicsBody?.contactTestBitMask = physicsCatagory.finishLine | physicsCatagory.usersShip
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
    }
}
