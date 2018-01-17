//
//  Asteroid.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/14/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit


class Asteroid: SKSpriteNode {
    
    let radius: CGFloat = 20
    
    let trail: SKEmitterNode = {
        let asteroidTrail = SKEmitterNode(fileNamed: "asteroidtrail.sks")!
        asteroidTrail.name = "asteroidtrail"
        asteroidTrail.zPosition = 30
        
        return asteroidTrail
    }()
    
    convenience init(asteroidName: String) {
        self.init(imageNamed: asteroidName)
        
        self.xScale = 1.5
        self.yScale = 1.5
        self.zPosition = 100
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.radius)
        self.physicsBody?.categoryBitMask = physicsCatagory.asteroid
        self.physicsBody?.collisionBitMask = physicsCatagory.asteroid | physicsCatagory.usersShip | physicsCatagory.planet
        self.physicsBody?.contactTestBitMask = physicsCatagory.asteroid | physicsCatagory.usersShip | physicsCatagory.planet | physicsCatagory.planetPath
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        
        self.addChild(trail)
    }
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(to point: CGPoint) {
        let forceVector = CGVector(dx: 0.2 * (point.x - self.position.x), dy:  0.2 * (point.y - self.position.y))
        let forceAction = SKAction.applyForce(forceVector, duration: 0.02)
        self.run(forceAction)
    }
    
    func spin() {
        self.physicsBody?.applyTorque(0.1)
    }
}


