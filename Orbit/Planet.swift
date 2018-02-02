//
//  Planet.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/14/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Planet: SKSpriteNode {
    
    convenience init(imageName: String) {
        self.init(imageNamed: imageName)
        
        self.setScale(2)
        self.zPosition = 50
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2.0)
        self.physicsBody?.categoryBitMask = physicsCatagory.planet
        self.physicsBody?.collisionBitMask = physicsCatagory.planet | physicsCatagory.usersShip
        self.physicsBody?.contactTestBitMask = physicsCatagory.planet | physicsCatagory.usersShip
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
    }
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func orbit(path: CGPath, speed: TimeInterval) {
        let circularMove = SKAction.follow(path, asOffset: false, orientToPath: false, duration: speed)
        self.run(SKAction.repeatForever(circularMove))
    }
    
    func addOrbitingPlanet(radius: CGFloat, planetImage: String, speed: TimeInterval) -> Planet {
        let planet = Planet(imageName: planetImage)
        planet.setScale(1)
        self.addChild(planet)
        let orbit = UIBezierPath(center: CGPoint.zero, radius: radius)
        planet.orbit(path: orbit.cgPath, speed: speed)
        
        return planet
    }
}

extension UIBezierPath {
    convenience init(center: CGPoint, radius: CGFloat) {
        self.init(ovalIn: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
    }
}
