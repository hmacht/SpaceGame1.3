//
//  Level26Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/15/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level26Scene: GameScene {
    
    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419", gravity: false)
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        _ = sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 1.8)
        
       
        let xPositions = [-200, 300, 0, -self.size.width/2, 100, -250]
        var yPos: CGFloat = 500
        
        for xPos in xPositions {
            let bH = BlackHole(imageName: "test")
            bH.position = CGPoint(x: xPos, y: yPos)
            self.addChild(bH)
            yPos += 500
        }
        
        
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: yPos)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: -50, y: 500), CGPoint(x: -200, y: 1500), CGPoint(x: 200, y: 3000)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns && self.scene!.speed > CGFloat(0) {
            for i in 0...3 {
                let wait = SKAction.wait(forDuration: 4.0 / Double(arc4random_uniform(5) + 1))
                
                self.run(SKAction.sequence([wait, SKAction.run({
                    self.createAsteroid(startPointY: self.usersShip.position.y + 525 + CGFloat(arc4random_uniform(200)), endPointY: nil)
                })]))
                self.timeSinceLastSpawn = 0
            }
        }
        super.update(currentTime)
    }
}
