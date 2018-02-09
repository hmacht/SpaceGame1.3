//
//  Level8Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/26/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level8Scene: GameScene {
    override func didMove(to view: SKView) {
        self.inLevel = true
        
        super.didMove(to: view)
        
        self.enableCameraFollow()
        
        
        // Finish line
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: 2050)
        self.addChild(finish)
        
        // First sun
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 3)
        
        // Second sun
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: 50, y: 550)
        self.addChild(sun2)
        
        // Second planet
        sun2.addOrbitingPlanet(radius: 180, planetImage: "Ellipse 8534", speed: 5)
        
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: 0, y: 1200)
        self.addChild(sun3)
        
        sun3.addOrbitingPlanet(radius: 180, planetImage: "Ellipse 8538", speed: 5.5)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 0, y: sun3.position.y + 450)
        self.addChild(sun4)
        
        sun4.addOrbitingPlanet(radius: 200, planetImage: "Ellipse 8533", speed: 4)
        
        self.gemPos = [CGPoint(x: sun2.position.x, y: sun2.position.y + 115), CGPoint(x: sun3.position.x - 115, y: sun3.position.y), CGPoint(x: 0, y: sun4.position.y + 120)]
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
