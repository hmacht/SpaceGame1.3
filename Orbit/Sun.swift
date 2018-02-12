//
//  Sun.swift
//  Orbit
//
//  Created by Henry Macht and Toby Kreiman on 1/14/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

public struct SunNames {
    static let redSun = "Group 770"
    static let yellowSun = "Group 761"
    static let greenSun = "Group 773"
    static let whiteSun = "Group 764"
    static let blueSun = "Group 767"
    static let blackSun = "Group 775"
    static let blackSun2 = "Group 776"
    static let blackSun3 = "Group 777"
    static let firstSun = "Group 419"
    static let firstGreenSun = "Group 287"
    static let sunNames = [/*SunNames.redSun, SunNames.greenSun, SunNames.yellowSun, SunNames.whiteSun, SunNames.blueSun, */SunNames.blackSun, SunNames.blackSun2, SunNames.blackSun3]
}

class Sun: SKSpriteNode {
    
    convenience init(imageName: String) {
        
        let imageN = SunNames.sunNames[Int(arc4random_uniform(UInt32(SunNames.sunNames.count)))]
        
        self.init(imageNamed: imageN)
        
        var scale: CGFloat = 1.5
        
        
        if imageN != "Group 419" && imageN != "Group 287" {
            //scale *= 184 / 244
        }
        
        self.setScale(scale)
        var physicsBodyRadius = self.size.width / 2.0
        
        if imageN != "Group 419" && imageN != "Group 287" {
            physicsBodyRadius = self.size.width / 2 - 15
        }
        
        self.zPosition = 80
        self.physicsBody = SKPhysicsBody(circleOfRadius: physicsBodyRadius)
        self.physicsBody?.categoryBitMask = physicsCatagory.sun
        self.physicsBody?.collisionBitMask = physicsCatagory.sun | physicsCatagory.usersShip | physicsCatagory.asteroid
        self.physicsBody?.contactTestBitMask = physicsCatagory.sun | physicsCatagory.usersShip | physicsCatagory.asteroid
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
        let randRotation = Double(arc4random_uniform(360)) * Double.pi / 180
        self.zRotation = CGFloat(randRotation)
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
