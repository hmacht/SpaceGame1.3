//
//  Level15Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/6/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level15Scene: GameScene {
    override func didMove(to view: SKView) {
        self.inLevel = true
        
        super.didMove(to: view)
        
        self.enableCameraFollow()
        
        // First sun
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        _ = sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 3)
        
        // Second sun
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: 200, y: sun.position.y + 500)
        self.addChild(sun2)
        
        // Second planet
        _ = sun2.addOrbitingPlanet(radius: 200, planetImage: "Ellipse 8534", speed: 2.3)
        
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: -250, y: sun.position.y + 500)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 180, planetImage: "planet", speed: 1.8)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 0, y: sun3.position.y + 580)
        self.addChild(sun4)
        
        _ = sun4.addOrbitingPlanet(radius: 300, planetImage: "Ellipse 8533", speed: 4)
        _ = sun4.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 2)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: -350, y: sun4.position.y + 650)
        self.addChild(sun5)
        
        _ = sun5.addOrbitingPlanet(radius: 350, planetImage: PlanetNames.redPlanet, speed: 2)
        
        let sun6 = Sun(imageName: "Group 287")
        sun6.position = CGPoint(x: self.size.width/2, y: sun5.position.y + 150)
        self.addChild(sun6)
        
        _ = sun6.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 1.6)
        
        // Finish line
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun6.position.y + 300)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: sun2.position.x, y: sun2.position.y + 115), CGPoint(x: sun4.position.x - 115, y: sun4.position.y), CGPoint(x: sun6.position.x, y: sun6.position.y - 120)]
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
