//
//  Level14Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/5/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level14Scene: GameScene {
    
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
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -self.size.width/2, y: 500)
        self.addChild(sun2)
        
        _ = sun2.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1.5)
        _ = sun2.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.yellowPlanet, speed: 2.3)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: self.size.width/2, y: sun2.position.y + 100)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 325, planetImage: PlanetNames.greenPlanet, speed: 2)
        _ = sun3.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1)
        
        let sun4 = Sun(imageName: "Group 287")
        sun4.position = CGPoint(x: -100, y: sun3.position.y + 320)
        self.addChild(sun4)
        
        _ = sun4.addOrbitingPlanet(radius: 120, planetImage: "planet", speed: 3)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: self.size.width/2, y: sun4.position.y + 600)
        self.addChild(sun5)
        
        _ = sun5.addOrbitingPlanet(radius: 120, planetImage: "planet", speed: 2)
        let p = sun5.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.redPlanet, speed: 2.4)
        _ = p.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 1.2)
        
        let sun6 = Sun(imageName: "Group 419")
        sun6.position = CGPoint(x: 0, y: sun5.position.y + 500)
        self.addChild(sun6)
        
        let p2 = sun6.addOrbitingPlanet(radius: 150, planetImage: PlanetNames.whitePlanet, speed: 2)
        p2.setScale(1)
        
        let sun7 = Sun(imageName: "Group 287")
        sun7.position = CGPoint(x: 150, y: sun6.position.y + 500)
        self.addChild(sun7)
        
        let p3 = sun7.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.yellowPlanet, speed: 2)
        _ = p3.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 1)
        
        // Finish Line
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun7.position.y + 400)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: sun4.position.x + 120, y: sun4.position.y), CGPoint(x: sun6.position.x, y: sun6.position.y - 115), CGPoint(x: sun7.position.x + 115, y: sun7.position.y)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns {
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
