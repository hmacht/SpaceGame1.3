//
//  AsteroidSpawner.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/15/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class AlertAsteroid: SKSpriteNode {
   
    var growTime: CGFloat = 0
    var shrinkTime: CGFloat = 0
    
    let whatAsteroid = ["Group 78","Group 80","Group 81"]
    
    convenience init(image: String, growTime: CGFloat, shrinkTime: CGFloat) {
        self.init(imageNamed: image)
        
        self.growTime = growTime
        self.shrinkTime = shrinkTime
        self.zPosition = 300
    }
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func warn() {
        let grow = SKAction.scale(to: 2, duration: TimeInterval(self.growTime))
        let shrink = SKAction.scale(to: 0, duration: TimeInterval(self.shrinkTime))
        self.run(SKAction.sequence([grow, shrink, SKAction.removeFromParent()]))
    }
}
