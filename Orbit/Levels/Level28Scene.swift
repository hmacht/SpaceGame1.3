//
//  Level28Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/19/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level28Scene: GameScene {
    
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
        
        var yPos: CGFloat = 500
        
        for i in 1...3 {
            let sun = Sun(imageName: "Group 419")
            sun.position = CGPoint(x: -self.size.width/2, y: yPos)
            self.addChild(sun)
            
            _ = sun.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.greenPlanet, speed: 2.2 - Double(i) * 0.1)
            
            let sun2 = Sun(imageName: "Group 419")
            sun2.position = CGPoint(x: self.size.width/2, y: yPos)
            self.addChild(sun2)
            
            _ = sun2.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.yellowPlanet, speed: 1.9 + Double(i) * 0.1)
            
            let bH = BlackHole(imageName: "blackHole")
            bH.position = CGPoint(x: 0, y: sun2.position.y + 350)
            self.addChild(bH)
            
            yPos = bH.position.y + 400
        }
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: 0, y: yPos + 350)
        self.addChild(sun2)
        
        let p = sun2.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.redPlanet, speed: 2.4)
        _ = p.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 0.55)
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun2.position.y + 500)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: -150, y: 500), CGPoint(x: 250, y: 800), CGPoint(x: sun2.position.x + 115, y: sun2.position.y)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns && self.scene!.speed > CGFloat(0) {
            for _ in 0...4 {
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
