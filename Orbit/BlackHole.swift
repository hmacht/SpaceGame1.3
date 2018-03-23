//
//  BlackHole.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/9/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class BlackHole: SKSpriteNode {
    
    convenience init(imageName: String = "Group 791") {
        
        self.init(imageNamed: "Group 791")
        
        self.setScale(1.75)
        self.zPosition = 40
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/5)
        self.physicsBody?.categoryBitMask = physicsCatagory.planet
        self.physicsBody?.collisionBitMask = physicsCatagory.planet | physicsCatagory.usersShip | physicsCatagory.asteroid
        self.physicsBody?.contactTestBitMask = physicsCatagory.planet | physicsCatagory.usersShip | physicsCatagory.asteroid
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.mass *= 0.15
        
        let gravityField = SKFieldNode.radialGravityField()
        self.addChild(gravityField)
    }
}

