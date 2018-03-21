//
//  Level29Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/19/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level29Scene: GameScene {
    
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
        let xPos = [200, -175, self.size.width/2, -300, 200, -150, 350, -self.size.width, 300, 0]
        let pNames = [PlanetNames.redPlanet, PlanetNames.yellowPlanet, PlanetNames.greenPlanet, PlanetNames.whitePlanet, "planet"]
        
        for i in 0...xPos.count-1 {
            let x = xPos[i]
            
            if i % 3 == 0 && i != 0 {
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
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: yPos)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: 0, y: 250), CGPoint(x: -50, y: 1000), CGPoint(x: -300, y: finish.position.y - 500)]
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
