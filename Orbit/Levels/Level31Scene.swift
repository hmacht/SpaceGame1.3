//
//  Level31Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/20/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level31Scene: GameScene {
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
        sun2.position = CGPoint(x: -self.size.width/2, y: 550)
        self.addChild(sun2)
        
        _ = sun2.addOrbitingPlanet(radius: 170, planetImage: "planet", speed: 1.7)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: self.size.width/2, y: sun2.position.y)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 170, planetImage: "planet", speed: 2)
        
        let blackHole = BlackHole(imageName: "blackHole")
        blackHole.position = CGPoint(x: 0, y: sun2.position.y)
        self.addChild(blackHole)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 0, y: blackHole.position.y + 600)
        self.addChild(sun4)
        
        _ = sun4.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.whitePlanet, speed: 2.2)
        _ = sun4.addOrbitingPlanet(radius: 170, planetImage: "planet", speed: 1.8)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: -250, y: sun4.position.y + 600)
        self.addChild(sun5)
        
        _ = sun5.addOrbitingPlanet(radius: 200, planetImage: PlanetNames.greenPlanet, speed: 2.4)
        
        let sun6 = Sun(imageName: "Group 419")
        sun6.position = CGPoint(x: 250, y: sun4.position.y + 600)
        self.addChild(sun6)
        
        _ = sun6.addOrbitingPlanet(radius: 180, planetImage: "planet", speed: 1.9)
        
        let blackHole2 = BlackHole(imageName: "blackHole")
        blackHole2.position = CGPoint(x: 0, y: sun6.position.y + 400)
        self.addChild(blackHole2)
        
        let sun7 = Sun(imageName: "Group 419")
        sun7.position = CGPoint(x: -self.size.width/2, y: blackHole2.position.y + 500)
        self.addChild(sun7)
        
        let p = sun7.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.yellowPlanet, speed: 2)
        _ = p.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 0.65)
        
        let bH3 = BlackHole(imageName: "blackHole")
        bH3.position = CGPoint(x: self.size.width/2, y: sun7.position.y + 400)
        self.addChild(bH3)
        
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: bH3.position.y + 375)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: sun2.position.x + 120, y: sun2.position.y), CGPoint(x: sun6.position.x - 110, y: sun6.position.y), CGPoint(x: sun7.position.x + 120, y: sun7.position.y )]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns && self.scene!.speed > CGFloat(0) {
            for _ in 0...6 {
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
