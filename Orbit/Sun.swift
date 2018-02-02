//
//  Sun.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/14/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Sun: SKSpriteNode {
    
    convenience init(imageName: String) {
        self.init(imageNamed: imageName)
        
        self.setScale(2)
        self.zPosition = 80
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2.0)
        self.physicsBody?.categoryBitMask = physicsCatagory.sun
        self.physicsBody?.collisionBitMask = physicsCatagory.sun | physicsCatagory.usersShip | physicsCatagory.asteroid
        self.physicsBody?.contactTestBitMask = physicsCatagory.sun | physicsCatagory.usersShip | physicsCatagory.asteroid
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
    }
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOrbitingPlanet(radius: CGFloat, planetImage: String, speed: TimeInterval) -> Planet {
        let planet = Planet(imageName: planetImage)
        self.parent?.addChild(planet)
        let orbit = UIBezierPath(center: self.position, radius: radius)
        planet.orbit(path: orbit.cgPath, speed: speed)
        
        return planet
    }
}
