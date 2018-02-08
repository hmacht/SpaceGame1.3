//
//  Level16Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/6/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level16Scene: GameScene {
    
    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        _ = sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2)
        
        
        let xPos = [200, -100, 300, 0, -self.size.width/2, 400, -150, 200, -self.size.width/2, self.size.width/2]
        var currentHeight: CGFloat = 0
        let pNames = [PlanetNames.redPlanet, PlanetNames.yellowPlanet, PlanetNames.greenPlanet, PlanetNames.whitePlanet, "planet"]
        
        for pos in xPos {
            currentHeight += 500
            let s = Sun(imageName: "Group 419")
            s.position = CGPoint(x: pos, y: currentHeight)
            self.addChild(s)
            
            _ = s.addOrbitingPlanet(radius: CGFloat(180 + arc4random_uniform(51)), planetImage: pNames[Int(arc4random_uniform(4))], speed: 1.7 + Double(arc4random_uniform(3)))
        }
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -self.size.width/2, y: currentHeight + 650)
        self.addChild(sun2)
        
        _ = sun2.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.whitePlanet, speed: 2)
        _ = sun2.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1.5)
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun2.position.y + 500)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: 0, y: 300), CGPoint(x: 300 - 115, y: 1500), CGPoint(x: sun2.position.x + 115, y: sun2.position.y)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns && self.scene!.speed > CGFloat(0) {
            for i in 0...2 {
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
