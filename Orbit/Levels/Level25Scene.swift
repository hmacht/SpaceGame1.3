//
//  Level25Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/13/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level25Scene: GameScene {
    
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
        sun2.position = CGPoint(x: -self.size.width/2, y: 500)
        self.addChild(sun2)
        
        _ = sun2.addOrbitingPlanet(radius: 350, planetImage: PlanetNames.redPlanet, speed: 2.2)
        _ = sun2.addOrbitingPlanet(radius: 170, planetImage: "planet", speed: 1.8)
        
        let bH = BlackHole(imageName: "Group 767")
        bH.position = CGPoint(x: self.size.width/2, y: sun2.position.y)
        self.addChild(bH)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: self.size.width/2, y: bH.position.y + 550)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 320, planetImage: PlanetNames.greenPlanet, speed: 2.4)
        _ = sun3.addOrbitingPlanet(radius: 170, planetImage: "planet", speed: 2)
        
        let bH2 = BlackHole(imageName: "Group 767")
        bH2.position = CGPoint(x: -self.size.width/2, y: sun3.position.y)
        self.addChild(bH2)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 0, y: bH2.position.y + 750)
        self.addChild(sun4)
        
        let p = sun4.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.yellowPlanet, speed: 2)
        _ = p.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 0.7)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: -self.size.width/2, y: sun4.position.y + 600)
        self.addChild(sun5)
        
        _ = sun5.addOrbitingPlanet(radius: 130, planetImage: "planet", speed: 2.2)
        
        let sun6 = Sun(imageName: "Group 419")
        sun6.position = CGPoint(x: 0, y: sun5.position.y + 100)
        self.addChild(sun6)
        
        _ = sun6.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1.8)
        
        let sun7 = Sun(imageName: "Group 419")
        sun7.position = CGPoint(x: self.size.width/2, y: sun5.position.y - 50)
        self.addChild(sun7)
        
        _ = sun7.addOrbitingPlanet(radius: 135, planetImage: "planet", speed: 2.4)
        
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun6.position.y + 300)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: sun6.position.x, y: sun6.position.y - 110), CGPoint(x: 0, y: bH.position.y), CGPoint(x: sun4.position.x - 115, y: sun4.position.y)]
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
