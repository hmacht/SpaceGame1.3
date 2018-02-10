//
//  Sun.swift
//  Orbit
//
//  Created by Henry Macht and Toby Kreiman on 1/14/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

public struct SunNames {
    static let redSun = "Group 749"
    static let yellowSun = "Group 747"
    static let greenSun = "Group 750"
    static let whiteSun = "Group 746"
    static let blueSun = "Group 748"
    static let blackSun = "Group 743"
    static let blackSun2 = "Group 744"
    static let blackSun3 = "Group 745"
    static let firstSun = "Group 419"
    static let firstGreenSun = "Group 287"
    static let sunNames = [SunNames.redSun, SunNames.greenSun, SunNames.yellowSun, SunNames.whiteSun, SunNames.blueSun, SunNames.blackSun, SunNames.blackSun2, SunNames.blackSun3, SunNames.firstSun, SunNames.firstGreenSun]
}

class Sun: SKSpriteNode {
    
    convenience init(imageName: String) {
        
        self.init(imageNamed: SunNames.sunNames[Int(arc4random_uniform(UInt32(SunNames.sunNames.count)))])
        
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
