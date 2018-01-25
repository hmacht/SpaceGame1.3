//
//  Gem.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/25/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Gem: SKSpriteNode {
    
    var touched = false
    
    convenience init(imageName: String) {
        //self.init(color: color, size: size)
        self.init(imageNamed: imageName)
        
        self.setScale(2)
        self.zPosition = 85
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2.0)
        self.physicsBody?.categoryBitMask = physicsCatagory.theGem
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = physicsCatagory.theGem | physicsCatagory.usersShip
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
    }
}
