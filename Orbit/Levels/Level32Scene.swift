//
//  Level32Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/20/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level32Scene: GameScene {
    
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
        let xPos = [-150, 300, -300, 0, self.size.width/2, -150, 250, -self.size.width/2, 0, 250]
        let pNames = [PlanetNames.redPlanet, PlanetNames.yellowPlanet, PlanetNames.greenPlanet, PlanetNames.whitePlanet, "planet"]
        
        for i in 0...xPos.count-1 {
            let x = xPos[i]
            
            if i % 4 == 0 && i != 0 {
                // Black Hole
                let bH = BlackHole(imageName: "blackHole")
                bH.position = CGPoint(x: x, y: yPos)
                self.addChild(bH)
            } else {
                let s = Sun(imageName: "Group 419")
                s.position = CGPoint(x: x, y: yPos)
                self.addChild(s)
                
                _ = s.addOrbitingPlanet(radius: CGFloat(180 + arc4random_uniform(51)), planetImage: pNames[Int(arc4random_uniform(4))], speed: 1.7 + Double(arc4random_uniform(3)))
            }
            yPos += 500
        }
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -self.size.width/2, y: yPos + 200)
        self.addChild(sun2)
        
        _ = sun2.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.whitePlanet, speed: 2.2)
        _ = sun2.addOrbitingPlanet(radius: 180, planetImage: "planet", speed: 1.8)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: -250, y: sun2.position.y + 600)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2.4)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 250, y: sun2.position.y + 600)
        self.addChild(sun4)
        
        _ = sun4.addOrbitingPlanet(radius: 180, planetImage: PlanetNames.bigBlue, speed: 1.9)
        
        let bH = BlackHole(imageName: "blackHole")
        bH.position = CGPoint(x: 0, y: sun4.position.y + 350)
        self.addChild(bH)
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: bH.position.y + 300)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: 0, y: 250), CGPoint(x: sun2.position.x + 120, y: sun2.position.y), CGPoint(x: bH.position.x - 250, y: bH.position.y)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns && self.scene!.speed > CGFloat(0) {
            for _ in 0...5 {
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
