//
//  Level2Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/15/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level2Scene: GameScene {
    
    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        self.timeInBetweenSpawns = 3.5
        
        // Finish Line
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: self.size.height - finish.size.height)
        self.addChild(finish)
        
        // First sun
        let sun = Sun(imageName: "Moon")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        // First planets
        let planet1 = Planet(imageName: "planet")
        planet1.position = CGPoint(x: 0, y: 0)
        self.addChild(planet1)
        let circle1 = UIBezierPath(ovalIn: CGRect(x: -200, y: -250, width: 400, height: 500))
        planet1.orbit(path: circle1.cgPath, speed: 2)
        
        // Level has camera
        self.enableCameraFollow()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)

        if self.timeSinceLastSpawn > self.timeInBetweenSpawns {
            self.timeSinceLastSpawn = 0
            self.createAsteroid(startPointY: usersShip.position.y + 375 + CGFloat(arc4random_uniform(100)), endPointY: nil)
        }
        super.update(currentTime)
    }

}
