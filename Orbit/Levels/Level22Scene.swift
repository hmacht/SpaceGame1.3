//
//  Level22Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/12/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level22Scene: GameScene {
    
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
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -250, y: 500)
        self.addChild(sun2)
        
        _ = sun2.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2.3)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: 250, y: 500)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 180, planetImage: PlanetNames.redPlanet, speed: 1.9)
        
        let bH = BlackHole(imageName: "Group 767")
        bH.position = CGPoint(x: 0, y: sun3.position.y + 350)
        self.addChild(bH)
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: bH.position.y + 250)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: 0, y: 250), CGPoint(x: -250, y: bH.position.y), CGPoint(x: 250, y: bH.position.y - 100)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns && self.scene!.speed > CGFloat(0) {
            for i in 0...3 {
                let wait = SKAction.wait(forDuration: 4.0 / Double(arc4random_uniform(5) + 1))
                
                self.run(SKAction.sequence([wait, SKAction.run({
                    self.createAsteroid(startPointY: self.usersShip.position.y + 425 + CGFloat(arc4random_uniform(200)), endPointY: nil)
                })]))
                self.timeSinceLastSpawn = 0
            }
        }
        super.update(currentTime)
    }
}
